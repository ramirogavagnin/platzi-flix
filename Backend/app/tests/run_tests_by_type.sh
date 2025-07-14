#!/bin/bash
# Script to run tests by type for Platziflix Course API

export DATABASE_URL=sqlite:///./test.db

case $1 in
    "unit")
        echo "🧪 Running Unit Tests (with mocks)"
        echo "================================="
        echo ""
        python -m pytest test_courses.py::TestGetCourses test_courses.py::TestGetCourseBySlug -v
        ;;
    "integration")
        echo "🧪 Running Integration Tests (with real DB)"
        echo "==========================================="
        echo ""
        python -m pytest test_courses.py::TestGetCoursesIntegration test_courses.py::TestGetCourseBySlugIntegration -v
        ;;
    "all")
        echo "🧪 Running All Tests"
        echo "==================="
        echo ""
        python -m pytest test_courses.py -v
        ;;
    *)
        echo "🧪 Platziflix - Test Runner by Type"
        echo "=================================="
        echo ""
        echo "Usage: $0 <test_type>"
        echo ""
        echo "Available test types:"
        echo ""
        echo "  unit         : Run only unit tests (fast, with mocks)"
        echo "  integration  : Run only integration tests (slower, with real DB)"
        echo "  all          : Run all tests"
        echo ""
        echo "Examples:"
        echo "  $0 unit         # Run unit tests only"
        echo "  $0 integration  # Run integration tests only"
        echo "  $0 all          # Run all tests"
        echo ""
        exit 1
        ;;
esac 