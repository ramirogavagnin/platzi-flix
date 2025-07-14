"""Tests for course endpoints."""

import pytest
from unittest.mock import Mock, patch
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from app.main import app
from app.services.course_service import CourseService, get_course_service
from app.db.base import Base, get_db
from app.db.models.course import Course
from app.db.models.lecture import Lecture
from app.db.models.teacher import Teacher
from app.db.models.course_teacher import CourseTeacher
from datetime import datetime


# Test database setup
TEST_DATABASE_URL = "sqlite:///./test_integration.db"
test_engine = create_engine(TEST_DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=test_engine)


def override_get_db():
    """Override database dependency for integration tests."""
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()


@pytest.fixture
def client():
    """Create a test client."""
    return TestClient(app)


@pytest.fixture
def mock_course_service():
    """Create a mock CourseService."""
    return Mock(spec=CourseService)


@pytest.fixture
def sample_courses():
    """Sample courses data following the contract."""
    return [
        {
            "id": 1,
            "name": "Curso de React",
            "description": "Curso de React",
            "thumbnail": "https://via.placeholder.com/150",
            "slug": "curso-de-react"
        },
        {
            "id": 2,
            "name": "Curso de Python",
            "description": "Curso de Python",
            "thumbnail": "https://via.placeholder.com/150",
            "slug": "curso-de-python"
        }
    ]


@pytest.fixture
def sample_course_detail():
    """Sample course detail data following the contract."""
    return {
        "id": 1,
        "name": "Curso de React",
        "description": "Curso de React",
        "thumbnail": "https://via.placeholder.com/150",
        "slug": "curso-de-react",
        "teacher_id": [1, 2, 3],
        "lectures": [
            {
                "id": 1,
                "name": "Clase 1",
                "description": "Clase 1",
                "slug": "clase-1"
            },
            {
                "id": 2,
                "name": "Clase 2",
                "description": "Clase 2",
                "slug": "clase-2"
            }
        ]
    }


@pytest.fixture
def db_session():
    """Create a database session for integration tests."""
    # Create the database tables
    Base.metadata.create_all(bind=test_engine)
    
    # Create session
    session = TestingSessionLocal()
    
    # Override the dependency
    app.dependency_overrides[get_db] = override_get_db
    
    try:
        yield session
    finally:
        session.close()
        # Clean up the database
        Base.metadata.drop_all(bind=test_engine)
        app.dependency_overrides.clear()


@pytest.fixture
def db_data(db_session):
    """Create test data in the database."""
    # Create teachers
    teacher1 = Teacher(id=1, name="Juan Pérez", email="juan@example.com")
    teacher2 = Teacher(id=2, name="María González", email="maria@example.com")
    teacher3 = Teacher(id=3, name="Carlos López", email="carlos@example.com")
    
    db_session.add_all([teacher1, teacher2, teacher3])
    db_session.commit()
    
    # Create courses
    course1 = Course(
        id=1,
        name="Curso de React",
        description="Curso de React",
        thumbnail="https://via.placeholder.com/150",
        slug="curso-de-react"
    )
    
    course2 = Course(
        id=2,
        name="Curso de Python",
        description="Curso de Python",
        thumbnail="https://via.placeholder.com/150",
        slug="curso-de-python"
    )
    
    db_session.add_all([course1, course2])
    db_session.commit()
    
    # Create course-teacher relationships
    course_teacher1 = CourseTeacher(course_id=1, teacher_id=1)
    course_teacher2 = CourseTeacher(course_id=1, teacher_id=2)
    course_teacher3 = CourseTeacher(course_id=2, teacher_id=3)
    
    db_session.add_all([course_teacher1, course_teacher2, course_teacher3])
    db_session.commit()
    
    # Create lectures
    lecture1 = Lecture(
        id=1,
        course_id=1,
        name="Clase 1",
        description="Clase 1",
        slug="clase-1",
        video_url="https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    )
    
    lecture2 = Lecture(
        id=2,
        course_id=1,
        name="Clase 2",
        description="Clase 2",
        slug="clase-2",
        video_url="https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    )
    
    lecture3 = Lecture(
        id=3,
        course_id=2,
        name="Introducción a Python",
        description="Introducción a Python",
        slug="intro-python",
        video_url="https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    )
    
    db_session.add_all([lecture1, lecture2, lecture3])
    db_session.commit()
    
    return {
        "courses": [course1, course2],
        "teachers": [teacher1, teacher2, teacher3],
        "lectures": [lecture1, lecture2, lecture3]
    }


class TestGetCourses:
    """Test cases for GET /courses endpoint."""

    @pytest.mark.unit
    def test_get_courses_success(self, client, mock_course_service, sample_courses):
        """Test successful retrieval of courses list."""
        # Arrange
        mock_course_service.get_courses.return_value = sample_courses
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses")
            
            # Assert
            assert response.status_code == 200
            assert response.json() == sample_courses
            mock_course_service.get_courses.assert_called_once()
        finally:
            # Cleanup
            app.dependency_overrides.clear()

    def test_get_courses_empty_list(self, client, mock_course_service):
        """Test retrieval of courses when no courses exist."""
        # Arrange
        mock_course_service.get_courses.return_value = []
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses")
            
            # Assert
            assert response.status_code == 200
            assert response.json() == []
            mock_course_service.get_courses.assert_called_once()
        finally:
            # Cleanup
            app.dependency_overrides.clear()

    def test_get_courses_contract_compliance(self, client, mock_course_service, sample_courses):
        """Test that response follows the contract structure."""
        # Arrange
        mock_course_service.get_courses.return_value = sample_courses
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses")
            
            # Assert
            assert response.status_code == 200
            courses = response.json()
            assert isinstance(courses, list)
            
            # Check each course has required fields
            for course in courses:
                assert "id" in course
                assert "name" in course
                assert "description" in course
                assert "thumbnail" in course
                assert "slug" in course
                assert isinstance(course["id"], int)
                assert isinstance(course["name"], str)
                assert isinstance(course["description"], str)
                assert isinstance(course["thumbnail"], str)
                assert isinstance(course["slug"], str)
        finally:
            # Cleanup
            app.dependency_overrides.clear()

    def test_get_courses_service_error(self, client, mock_course_service):
        """Test handling of service errors."""
        # Arrange
        mock_course_service.get_courses.side_effect = Exception("Database error")
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses")
            
            # Assert
            assert response.status_code == 500
            assert "Error fetching courses" in response.json()["detail"]
        finally:
            # Cleanup
            app.dependency_overrides.clear()


class TestGetCourseBySlug:
    """Test cases for GET /courses/{slug} endpoint."""

    def test_get_course_by_slug_success(self, client, mock_course_service, sample_course_detail):
        """Test successful retrieval of course by slug."""
        # Arrange
        mock_course_service.get_course_by_slug.return_value = sample_course_detail
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses/curso-de-react")
            
            # Assert
            assert response.status_code == 200
            assert response.json() == sample_course_detail
            mock_course_service.get_course_by_slug.assert_called_once_with("curso-de-react")
        finally:
            # Cleanup
            app.dependency_overrides.clear()

    def test_get_course_by_slug_not_found(self, client, mock_course_service):
        """Test retrieval of non-existent course."""
        # Arrange
        mock_course_service.get_course_by_slug.return_value = None
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses/non-existent-course")
            
            # Assert
            assert response.status_code == 404
            assert response.json()["detail"] == "Course not found"
            mock_course_service.get_course_by_slug.assert_called_once_with("non-existent-course")
        finally:
            # Cleanup
            app.dependency_overrides.clear()

    def test_get_course_by_slug_contract_compliance(self, client, mock_course_service, sample_course_detail):
        """Test that response follows the contract structure."""
        # Arrange
        mock_course_service.get_course_by_slug.return_value = sample_course_detail
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses/curso-de-react")
            
            # Assert
            assert response.status_code == 200
            course = response.json()
            
            # Check required fields
            assert "id" in course
            assert "name" in course
            assert "description" in course
            assert "thumbnail" in course
            assert "slug" in course
            assert "teacher_id" in course
            assert "lectures" in course
            
            # Check types
            assert isinstance(course["id"], int)
            assert isinstance(course["name"], str)
            assert isinstance(course["description"], str)
            assert isinstance(course["thumbnail"], str)
            assert isinstance(course["slug"], str)
            assert isinstance(course["teacher_id"], list)
            assert isinstance(course["lectures"], list)
            
            # Check teacher_id array contains integers (as per contract)
            for teacher_id in course["teacher_id"]:
                assert isinstance(teacher_id, int)
            
            # Check lectures structure
            for lecture in course["lectures"]:
                assert "id" in lecture
                assert "name" in lecture
                assert "description" in lecture
                assert "slug" in lecture
                assert isinstance(lecture["id"], int)
                assert isinstance(lecture["name"], str)
                assert isinstance(lecture["description"], str)
                assert isinstance(lecture["slug"], str)
        finally:
            # Cleanup
            app.dependency_overrides.clear()

    def test_get_course_by_slug_service_error(self, client, mock_course_service):
        """Test handling of service errors."""
        # Arrange
        mock_course_service.get_course_by_slug.side_effect = Exception("Database error")
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses/curso-de-react")
            
            # Assert
            assert response.status_code == 500
            assert "Error fetching course" in response.json()["detail"]
        finally:
            # Cleanup
            app.dependency_overrides.clear()

    def test_get_course_by_slug_special_characters(self, client, mock_course_service):
        """Test handling of slugs with special characters."""
        # Arrange
        course_data = {
            "id": 1,
            "name": "Curso con-carácteres-especiales",
            "description": "Curso con carácteres especiales",
            "thumbnail": "https://via.placeholder.com/150",
            "slug": "curso-con-caracteres-especiales",
            "teacher_id": [1],
            "lectures": []
        }
        mock_course_service.get_course_by_slug.return_value = course_data
        
        # Override the dependency
        app.dependency_overrides[get_course_service] = lambda: mock_course_service
        
        try:
            # Act
            response = client.get("/courses/curso-con-caracteres-especiales")
            
            # Assert
            assert response.status_code == 200
            assert response.json() == course_data
            mock_course_service.get_course_by_slug.assert_called_once_with("curso-con-caracteres-especiales")
        finally:
            # Cleanup
            app.dependency_overrides.clear()


class TestGetCoursesIntegration:
    """Integration test cases for GET /courses endpoint using real database."""

    def test_get_courses_success_integration(self, client, db_session, db_data):
        """Test successful retrieval of courses list from database."""
        # Act
        response = client.get("/courses")
        
        # Assert
        assert response.status_code == 200
        courses = response.json()
        assert len(courses) == 2
        
        # Create a dictionary for easier lookup
        courses_by_slug = {course["slug"]: course for course in courses}
        
        # Check that both courses are present
        assert "curso-de-react" in courses_by_slug
        assert "curso-de-python" in courses_by_slug
        
        # Check React course
        react_course = courses_by_slug["curso-de-react"]
        assert react_course["name"] == "Curso de React"
        assert react_course["description"] == "Curso de React"
        assert react_course["thumbnail"] == "https://via.placeholder.com/150"
        assert "id" in react_course
        
        # Check Python course
        python_course = courses_by_slug["curso-de-python"]
        assert python_course["name"] == "Curso de Python"
        assert python_course["description"] == "Curso de Python"
        assert python_course["thumbnail"] == "https://via.placeholder.com/150"
        assert "id" in python_course

    def test_get_courses_empty_list_integration(self, client, db_session):
        """Test retrieval of courses when no courses exist in database."""
        # Act (no data created)
        response = client.get("/courses")
        
        # Assert
        assert response.status_code == 200
        assert response.json() == []

    def test_get_courses_contract_compliance_integration(self, client, db_session, db_data):
        """Test that response follows the contract structure from database."""
        # Act
        response = client.get("/courses")
        
        # Assert
        assert response.status_code == 200
        courses = response.json()
        assert isinstance(courses, list)
        
        # Check each course has required fields
        for course in courses:
            assert "id" in course
            assert "name" in course
            assert "description" in course
            assert "thumbnail" in course
            assert "slug" in course
            assert isinstance(course["id"], int)
            assert isinstance(course["name"], str)
            assert isinstance(course["description"], str)
            assert isinstance(course["thumbnail"], str)
            assert isinstance(course["slug"], str)

    def test_get_courses_soft_delete_integration(self, client, db_session, db_data):
        """Test that soft deleted courses are not returned."""
        # Arrange - soft delete one course
        course_to_delete = db_session.query(Course).filter(Course.slug == "curso-de-react").first()
        course_to_delete.deleted_at = datetime.now()
        db_session.commit()
        
        # Act
        response = client.get("/courses")
        
        # Assert
        assert response.status_code == 200
        courses = response.json()
        assert len(courses) == 1
        assert courses[0]["slug"] == "curso-de-python"


class TestGetCourseBySlugIntegration:
    """Integration test cases for GET /courses/{slug} endpoint using real database."""

    def test_get_course_by_slug_success_integration(self, client, db_session, db_data):
        """Test successful retrieval of course by slug from database."""
        # Act
        response = client.get("/courses/curso-de-react")
        
        # Assert
        assert response.status_code == 200
        course = response.json()
        
        # Check basic course info
        assert course["name"] == "Curso de React"
        assert course["description"] == "Curso de React"
        assert course["slug"] == "curso-de-react"
        assert course["thumbnail"] == "https://via.placeholder.com/150"
        assert "id" in course
        
        # Check teachers (should be objects with id and name)
        assert "teacher_id" in course
        assert isinstance(course["teacher_id"], list)
        assert len(course["teacher_id"]) == 2
        
        # Check teacher structure
        for teacher in course["teacher_id"]:
            assert "id" in teacher
            assert "name" in teacher
            assert isinstance(teacher["id"], int)
            assert isinstance(teacher["name"], str)
        
        # Check lectures
        assert "lectures" in course
        assert isinstance(course["lectures"], list)
        assert len(course["lectures"]) == 2
        
        # Check lecture structure
        for lecture in course["lectures"]:
            assert "id" in lecture
            assert "name" in lecture
            assert "description" in lecture
            assert "slug" in lecture
            assert isinstance(lecture["id"], int)
            assert isinstance(lecture["name"], str)
            assert isinstance(lecture["description"], str)
            assert isinstance(lecture["slug"], str)

    def test_get_course_by_slug_not_found_integration(self, client, db_session, db_data):
        """Test retrieval of non-existent course from database."""
        # Act
        response = client.get("/courses/non-existent-course")
        
        # Assert
        assert response.status_code == 404
        assert response.json()["detail"] == "Course not found"

    def test_get_course_by_slug_contract_compliance_integration(self, client, db_session, db_data):
        """Test that response follows the contract structure from database."""
        # Act
        response = client.get("/courses/curso-de-react")
        
        # Assert
        assert response.status_code == 200
        course = response.json()
        
        # Check required fields
        assert "id" in course
        assert "name" in course
        assert "description" in course
        assert "thumbnail" in course
        assert "slug" in course
        assert "teacher_id" in course
        assert "lectures" in course
        
        # Check types
        assert isinstance(course["id"], int)
        assert isinstance(course["name"], str)
        assert isinstance(course["description"], str)
        assert isinstance(course["thumbnail"], str)
        assert isinstance(course["slug"], str)
        assert isinstance(course["teacher_id"], list)
        assert isinstance(course["lectures"], list)
        
        # Check teacher_id array contains objects with id and name
        for teacher in course["teacher_id"]:
            assert isinstance(teacher, dict)
            assert "id" in teacher
            assert "name" in teacher
            assert isinstance(teacher["id"], int)
            assert isinstance(teacher["name"], str)
        
        # Check lectures structure
        for lecture in course["lectures"]:
            assert "id" in lecture
            assert "name" in lecture
            assert "description" in lecture
            assert "slug" in lecture
            assert isinstance(lecture["id"], int)
            assert isinstance(lecture["name"], str)
            assert isinstance(lecture["description"], str)
            assert isinstance(lecture["slug"], str)

    def test_get_course_by_slug_soft_delete_integration(self, client, db_session, db_data):
        """Test that soft deleted courses are not returned."""
        # Arrange - soft delete the course
        course_to_delete = db_session.query(Course).filter(Course.slug == "curso-de-react").first()
        course_to_delete.deleted_at = datetime.now()
        db_session.commit()
        
        # Act
        response = client.get("/courses/curso-de-react")
        
        # Assert
        assert response.status_code == 404
        assert response.json()["detail"] == "Course not found"

    def test_get_course_by_slug_soft_delete_teachers_integration(self, client, db_session, db_data):
        """Test that soft deleted teachers are not included in course response."""
        # Arrange - soft delete one teacher
        teacher_to_delete = db_session.query(Teacher).filter(Teacher.id == 1).first()
        teacher_to_delete.deleted_at = datetime.now()
        db_session.commit()
        
        # Act
        response = client.get("/courses/curso-de-react")
        
        # Assert
        assert response.status_code == 200
        course = response.json()
        assert len(course["teacher_id"]) == 1  # Only one teacher should remain
        assert course["teacher_id"][0]["id"] == 2  # Should be the second teacher

    def test_get_course_by_slug_soft_delete_lectures_integration(self, client, db_session, db_data):
        """Test that soft deleted lectures are not included in course response."""
        # Arrange - soft delete one lecture
        lecture_to_delete = db_session.query(Lecture).filter(Lecture.id == 1).first()
        lecture_to_delete.deleted_at = datetime.now()
        db_session.commit()
        
        # Act
        response = client.get("/courses/curso-de-react")
        
        # Assert
        assert response.status_code == 200
        course = response.json()
        assert len(course["lectures"]) == 1  # Only one lecture should remain
        assert course["lectures"][0]["id"] == 2  # Should be the second lecture 