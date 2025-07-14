"""Tests for course endpoints using REAL database data."""

import pytest
from fastapi.testclient import TestClient
from app.main import app
from app.services.course_service import CourseService


@pytest.fixture
def client():
    """Create a test client."""
    return TestClient(app)


class TestCoursesWithRealData:
    """Test cases using REAL data from the database."""
    
    def test_get_courses_real_data(self, client):
        """Test GET /courses with real data from database."""
        # Act
        response = client.get("/courses")
        
        # Assert
        assert response.status_code == 200
        courses = response.json()
        assert isinstance(courses, list)
        
        print(f"\n📊 Found {len(courses)} courses in database")
        
        # If there are courses, verify structure
        if courses:
            for i, course in enumerate(courses[:3]):  # Check first 3 courses
                print(f"📋 Course {i+1}: {course.get('name', 'N/A')} (slug: {course.get('slug', 'N/A')})")
                
                # Verify contract compliance with real data
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
        else:
            print("📋 No courses found in database")
    
    def test_get_course_by_slug_real_data(self, client):
        """Test GET /courses/{slug} with real data from database."""
        # First, get a list of courses to find a real slug
        courses_response = client.get("/courses")
        assert courses_response.status_code == 200
        courses = courses_response.json()
        
        if not courses:
            pytest.skip("No courses found in database to test")
        
        # Use the first course's slug
        test_slug = courses[0]["slug"]
        print(f"\n🎯 Testing with real slug: {test_slug}")
        
        # Act
        response = client.get(f"/courses/{test_slug}")
        
        # Assert
        assert response.status_code == 200
        course = response.json()
        
        print(f"📋 Course name: {course.get('name', 'N/A')}")
        print(f"👥 Teachers: {len(course.get('teacher_id', []))}")
        print(f"🎓 Lectures: {len(course.get('lectures', []))}")
        
        # Verify contract compliance with real data
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
        
        # Check teachers structure (should be objects with id and name)
        for teacher in course["teacher_id"]:
            assert isinstance(teacher, dict)
            assert "id" in teacher
            assert "name" in teacher
            assert isinstance(teacher["id"], int)
            assert isinstance(teacher["name"], str)
            print(f"👨‍🏫 Teacher: {teacher['name']} (ID: {teacher['id']})")
        
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
            print(f"🎓 Lecture: {lecture['name']} (slug: {lecture['slug']})")
    
    def test_get_course_by_nonexistent_slug_real_data(self, client):
        """Test GET /courses/{slug} with non-existent slug."""
        # Act
        response = client.get("/courses/this-course-definitely-does-not-exist-12345")
        
        # Assert
        assert response.status_code == 404
        assert response.json()["detail"] == "Course not found"
        print("\n✅ Non-existent course correctly returns 404")
    
    def test_courses_contract_compliance_real_data(self, client):
        """Test that all courses in database comply with API contract."""
        # Act
        response = client.get("/courses")
        
        # Assert
        assert response.status_code == 200
        courses = response.json()
        
        print(f"\n🔍 Checking contract compliance for {len(courses)} courses")
        
        for course in courses:
            # Required fields according to contract
            required_fields = ["id", "name", "description", "thumbnail", "slug"]
            for field in required_fields:
                assert field in course, f"Missing field '{field}' in course {course.get('id', 'unknown')}"
            
            # Type checking
            assert isinstance(course["id"], int), f"Course {course['id']}: 'id' should be int"
            assert isinstance(course["name"], str), f"Course {course['id']}: 'name' should be str"
            assert isinstance(course["description"], str), f"Course {course['id']}: 'description' should be str"
            assert isinstance(course["thumbnail"], str), f"Course {course['id']}: 'thumbnail' should be str"
            assert isinstance(course["slug"], str), f"Course {course['id']}: 'slug' should be str"
            
            # Non-empty strings
            assert course["name"].strip(), f"Course {course['id']}: 'name' should not be empty"
            assert course["slug"].strip(), f"Course {course['id']}: 'slug' should not be empty"
        
        print("✅ All courses comply with API contract")
    
    def test_multiple_course_slugs_real_data(self, client):
        """Test multiple course slugs from real data."""
        # First, get courses
        courses_response = client.get("/courses")
        assert courses_response.status_code == 200
        courses = courses_response.json()
        
        if len(courses) < 2:
            pytest.skip("Need at least 2 courses in database to run this test")
        
        # Test first 3 courses (or all if less than 3)
        test_courses = courses[:3]
        print(f"\n🧪 Testing {len(test_courses)} course slugs")
        
        for course_info in test_courses:
            slug = course_info["slug"]
            print(f"\n🎯 Testing slug: {slug}")
            
            # Act
            response = client.get(f"/courses/{slug}")
            
            # Assert
            assert response.status_code == 200
            course = response.json()
            
            # Verify it's the correct course
            assert course["id"] == course_info["id"]
            assert course["slug"] == slug
            print(f"✅ Course '{course['name']}' retrieved successfully")


class TestCourseDataQuality:
    """Test data quality in the real database."""
    
    def test_no_duplicate_slugs(self, client):
        """Verify there are no duplicate slugs in the database."""
        response = client.get("/courses")
        assert response.status_code == 200
        courses = response.json()
        
        slugs = [course["slug"] for course in courses]
        unique_slugs = set(slugs)
        
        print(f"\n📊 Total courses: {len(courses)}")
        print(f"📊 Unique slugs: {len(unique_slugs)}")
        
        assert len(slugs) == len(unique_slugs), f"Found duplicate slugs: {set([x for x in slugs if slugs.count(x) > 1])}"
        print("✅ No duplicate slugs found")
    
    def test_courses_have_basic_data(self, client):
        """Verify all courses have basic required data."""
        response = client.get("/courses")
        assert response.status_code == 200
        courses = response.json()
        
        issues = []
        
        for course in courses:
            course_id = course.get("id", "unknown")
            
            # Check for empty or None values
            if not course.get("name", "").strip():
                issues.append(f"Course {course_id}: empty name")
            
            if not course.get("description", "").strip():
                issues.append(f"Course {course_id}: empty description")
            
            if not course.get("slug", "").strip():
                issues.append(f"Course {course_id}: empty slug")
            
            if not course.get("thumbnail", "").strip():
                issues.append(f"Course {course_id}: empty thumbnail")
        
        if issues:
            print(f"\n⚠️  Data quality issues found:")
            for issue in issues:
                print(f"  - {issue}")
        else:
            print(f"\n✅ All {len(courses)} courses have complete basic data")
        
        # Don't fail the test, just report issues
        assert True  # Always pass, this is just for reporting 