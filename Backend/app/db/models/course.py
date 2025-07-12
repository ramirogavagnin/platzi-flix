from sqlalchemy import Column, Integer, String, Text, DateTime, Index
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base


class Course(Base):
    __tablename__ = "courses"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    description = Column(Text, nullable=False)
    thumbnail = Column(String(500), nullable=False)
    slug = Column(String(255), unique=True, nullable=False, index=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)
    deleted_at = Column(DateTime(timezone=True), nullable=True)

    # Relationships
    teachers = relationship("Teacher", secondary="course_teacher", back_populates="courses")
    lectures = relationship("Lecture", back_populates="course")

    # Indexes for optimization
    __table_args__ = (
        Index('idx_courses_deleted_at', 'deleted_at'),
        Index('idx_courses_slug_deleted_at', 'slug', 'deleted_at'),
    ) 