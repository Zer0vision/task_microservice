# Сборка зависимостей
FROM python:3.10 AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Финальный образ
FROM python:3.10-slim
WORKDIR /app
RUN apt-get update && apt-get install -y libmariadb-dev gcc && rm -rf /var/lib/apt/lists/*
COPY --from=builder /root/.local /root/.local
COPY app/ app/
ENV PATH=/root/.local/bin:$PATH
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5000"]
