from sqlalchemy import Column, Integer, String, DateTime, Index
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base


class Teacher(Base):
    __tablename__ = "teachers"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, nullable=False, index=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)
    deleted_at = Column(DateTime(timezone=True), nullable=True)

    # Relationship with courses (many-to-many)
    courses = relationship("Course", secondary="course_teacher", back_populates="teachers")

    # Indexes for soft delete optimization
    __table_args__ = (
        Index('idx_teachers_deleted_at', 'deleted_at'),
        Index('idx_teachers_email_deleted_at', 'email', 'deleted_at'),
    ) 