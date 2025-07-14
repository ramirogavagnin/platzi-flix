"""Course service for business logic related to courses."""

from typing import List, Optional, Dict, Any
from sqlalchemy.orm import Session, joinedload
from app.db.models.course import Course
from app.db.models.lecture import Lecture
from app.db.models.teacher import Teacher


class CourseService:
    """Service class for course-related operations."""

    def __init__(self, db: Session):
        """Initialize the course service with database session."""
        self.db = db

    def get_courses(self) -> List[Dict[str, Any]]:
        """
        Get all courses (not deleted).
        
        Returns a list of courses with id, name, description, thumbnail, and slug.
        """
        courses = (
            self.db.query(Course)
            .filter(Course.deleted_at.is_(None))
            .order_by(Course.created_at.desc())
            .all()
        )
        
        return [
            {
                "id": course.id,
                "name": course.name,
                "description": course.description,
                "thumbnail": course.thumbnail,
                "slug": course.slug
            }
            for course in courses
        ]

    def get_course_by_slug(self, slug: str) -> Optional[Dict[str, Any]]:
        """
        Get a course by its slug with detailed information.
        
        Returns course with id, name, description, thumbnail, slug, teacher_id array, and lectures array.
        """
        course = (
            self.db.query(Course)
            .options(
                joinedload(Course.teachers),
                joinedload(Course.lectures)
            )
            .filter(Course.slug == slug)
            .filter(Course.deleted_at.is_(None))
            .first()
        )
        
        if not course:
            return None
            
        # Get teachers with their information
        teachers = [
            {
                "id": teacher.id,
                "name": teacher.name
            }
            for teacher in course.teachers
            if teacher.deleted_at is None
        ]
        
        # Get lectures (only non-deleted)
        lectures = [
            {
                "id": lecture.id,
                "name": lecture.name,
                "description": lecture.description,
                "slug": lecture.slug
            }
            for lecture in course.lectures
            if lecture.deleted_at is None
        ]
        
        return {
            "id": course.id,
            "name": course.name,
            "description": course.description,
            "thumbnail": course.thumbnail,
            "slug": course.slug,
            "teacher_id": teachers,
            "lectures": lectures
        } 