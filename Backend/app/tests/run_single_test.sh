#!/bin/bash
# Script to run individual tests for Platziflix Course API

export DATABASE_URL=sqlite:///./test.db

if [ $# -eq 0 ]; then
    echo "🧪 Platziflix - Individual Test Runner"
    echo "====================================="
    echo ""
    echo "Usage: $0 <test_name>"
    echo ""
    echo "Available tests:"
    echo ""
    echo "📋 Unit Tests (GET /courses):"
    echo "  - success           : Test successful retrieval of courses"
    echo "  - empty             : Test empty courses list"
    echo "  - contract          : Test contract compliance"
    echo "  - error             : Test service error handling"
    echo ""
    echo "📋 Unit Tests (GET /courses/{slug}):"
    echo "  - slug_success      : Test successful retrieval by slug"
    echo "  - slug_not_found    : Test 404 handling"
    echo "  - slug_contract     : Test contract compliance"
    echo "  - slug_error        : Test service error handling"
    echo "  - slug_special      : Test special characters"
    echo ""
    echo "📋 Integration Tests (GET /courses):"
    echo "  - int_success       : Test successful retrieval with DB"
    echo "  - int_empty         : Test empty list with DB"
    echo "  - int_contract      : Test contract compliance with DB"
    echo "  - int_soft_delete   : Test soft delete with DB"
    echo ""
    echo "📋 Integration Tests (GET /courses/{slug}):"
    echo "  - int_slug_success  : Test successful retrieval by slug with DB"
    echo "  - int_slug_not_found: Test 404 handling with DB"
    echo "  - int_slug_contract : Test contract compliance with DB"
    echo "  - int_slug_soft_delete: Test soft delete with DB"
    echo "  - int_slug_soft_teachers: Test soft delete teachers with DB"
    echo "  - int_slug_soft_lectures: Test soft delete lectures with DB"
    echo ""
    echo "📋 Test Types:"
    echo "  - unit              : Run all unit tests (mocked)"
    echo "  - integration       : Run all integration tests (real DB)"
    echo "  - all               : Run all tests"
    echo ""
    echo "📋 Examples:"
    echo "  $0 success          # Run courses success test"
    echo "  $0 int_success      # Run courses integration test"
    echo "  $0 unit             # Run all unit tests"
    echo "  $0 integration      # Run all integration tests"
    echo ""
    exit 1
fi

case $1 in
    "success")
        echo "🧪 Running: GET /courses success test (unit)"
        python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v
        ;;
    "empty")
        echo "🧪 Running: GET /courses empty list test (unit)"
        python -m pytest test_courses.py::TestGetCourses::test_get_courses_empty_list -v
        ;;
    "contract")
        echo "🧪 Running: Contract compliance tests (unit)"
        python -m pytest test_courses.py -k "contract and not integration" -v
        ;;
    "error")
        echo "🧪 Running: Service error handling tests (unit)"
        python -m pytest test_courses.py -k "error and not integration" -v
        ;;
    "slug_success")
        echo "🧪 Running: GET /courses/{slug} success test (unit)"
        python -m pytest test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_success -v
        ;;
    "slug_not_found")
        echo "🧪 Running: GET /courses/{slug} not found test (unit)"
        python -m pytest test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_not_found -v
        ;;
    "slug_contract")
        echo "🧪 Running: GET /courses/{slug} contract compliance test (unit)"
        python -m pytest test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_contract_compliance -v
        ;;
    "slug_error")
        echo "🧪 Running: GET /courses/{slug} service error test (unit)"
        python -m pytest test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_service_error -v
        ;;
    "slug_special")
        echo "🧪 Running: GET /courses/{slug} special characters test (unit)"
        python -m pytest test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_special_characters -v
        ;;
    # Integration tests
    "int_success")
        echo "🧪 Running: GET /courses success test (integration)"
        python -m pytest test_courses.py::TestGetCoursesIntegration::test_get_courses_success_integration -v
        ;;
    "int_empty")
        echo "🧪 Running: GET /courses empty list test (integration)"
        python -m pytest test_courses.py::TestGetCoursesIntegration::test_get_courses_empty_list_integration -v
        ;;
    "int_contract")
        echo "🧪 Running: GET /courses contract compliance test (integration)"
        python -m pytest test_courses.py::TestGetCoursesIntegration::test_get_courses_contract_compliance_integration -v
        ;;
    "int_soft_delete")
        echo "🧪 Running: GET /courses soft delete test (integration)"
        python -m pytest test_courses.py::TestGetCoursesIntegration::test_get_courses_soft_delete_integration -v
        ;;
    "int_slug_success")
        echo "🧪 Running: GET /courses/{slug} success test (integration)"
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration::test_get_course_by_slug_success_integration -v
        ;;
    "int_slug_not_found")
        echo "🧪 Running: GET /courses/{slug} not found test (integration)"
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration::test_get_course_by_slug_not_found_integration -v
        ;;
    "int_slug_contract")
        echo "🧪 Running: GET /courses/{slug} contract compliance test (integration)"
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration::test_get_course_by_slug_contract_compliance_integration -v
        ;;
    "int_slug_soft_delete")
        echo "🧪 Running: GET /courses/{slug} soft delete test (integration)"
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration::test_get_course_by_slug_soft_delete_integration -v
        ;;
    "int_slug_soft_teachers")
        echo "🧪 Running: GET /courses/{slug} soft delete teachers test (integration)"
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration::test_get_course_by_slug_soft_delete_teachers_integration -v
        ;;
    "int_slug_soft_lectures")
        echo "🧪 Running: GET /courses/{slug} soft delete lectures test (integration)"
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration::test_get_course_by_slug_soft_delete_lectures_integration -v
        ;;
    # Test types
    "unit")
        echo "🧪 Running: All unit tests (mocked)"
        python -m pytest test_courses.py::TestGetCourses -v
        python -m pytest test_courses.py::TestGetCourseBySlug -v
        ;;
    "integration")
        echo "🧪 Running: All integration tests (real DB)"
        python -m pytest test_courses.py::TestGetCoursesIntegration -v
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration -v
        ;;
    "all")
        echo "🧪 Running: All tests"
        python -m pytest test_courses.py -v
        ;;
    *)
        echo "❌ Unknown test: $1"
        echo "Run '$0' without arguments to see available tests"
        exit 1
        ;;
esac 