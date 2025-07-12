from sqlalchemy import Column, Integer, ForeignKey, Index
from app.db.base import Base


class CourseTeacher(Base):
    __tablename__ = "course_teacher"

    course_id = Column(Integer, ForeignKey("courses.id"), primary_key=True)
    teacher_id = Column(Integer, ForeignKey("teachers.id"), primary_key=True)

    # Indexes for optimization
    __table_args__ = (
        Index('idx_course_teacher_course_id', 'course_id'),
        Index('idx_course_teacher_teacher_id', 'teacher_id'),
    ) 