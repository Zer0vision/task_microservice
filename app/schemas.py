from pydantic import BaseModel, field_validator

class TaskBase(BaseModel):
    title: str
    description: str | None = None
    done: bool = False

    @field_validator('title')
    def title_must_not_be_empty(cls, value):
        if not value.strip():
            raise ValueError('Title cannot be empty')
        return value

class TaskCreate(TaskBase):
    pass

class Task(TaskBase):
    id: int

    class Config:
        from_attributes = True
