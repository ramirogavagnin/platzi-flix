#!/bin/bash
# Script to run tests with REAL database data

echo "⚠️  WARNING: Running tests with REAL database"
echo "============================================="
echo ""
echo "This will run tests against your actual database."
echo "Make sure you're using a development database, NOT production!"
echo ""

# Check if user wants to continue
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled by user"
    exit 1
fi

echo ""
echo "🚀 Running tests with real database..."
echo ""

# Use the real database URL from environment or default
if [ -z "$DATABASE_URL" ]; then
    echo "❌ ERROR: DATABASE_URL environment variable is not set"
    echo "Please set it to your database connection string:"
    echo "export DATABASE_URL='postgresql://user:password@localhost:5432/platziflix'"
    exit 1
fi

echo "📊 Database URL: ${DATABASE_URL}"
echo ""

case $1 in
    "unit")
        echo "🧪 Running Unit Tests (these don't use the database anyway)"
        python -m pytest test_courses.py::TestGetCourses test_courses.py::TestGetCourseBySlug -v
        ;;
    "integration")
        echo "🗄️ Running Integration Tests with REAL database"
        echo "Note: These will still use test data fixtures, but on your real DB"
        python -m pytest test_courses.py::TestGetCoursesIntegration test_courses.py::TestGetCourseBySlugIntegration -v
        ;;
    "courses-only")
        echo "📋 Testing ONLY courses endpoint with real data"
        python -m pytest test_courses.py::TestGetCoursesIntegration::test_get_courses_success_integration -v
        ;;
    "slug-only")
        echo "📋 Testing ONLY course by slug endpoint with real data"
        python -m pytest test_courses.py::TestGetCourseBySlugIntegration::test_get_course_by_slug_success_integration -v
        ;;
    "all")
        echo "🧪 Running ALL tests"
        python -m pytest test_courses.py -v
        ;;
    *)
        echo "🗄️ Real Database Test Runner"
        echo "============================"
        echo ""
        echo "Usage: $0 <test_type>"
        echo ""
        echo "Available test types:"
        echo ""
        echo "  unit         : Run unit tests (don't use DB anyway)"
        echo "  integration  : Run integration tests with real DB"
        echo "  courses-only : Test only GET /courses with real data"
        echo "  slug-only    : Test only GET /courses/{slug} with real data"
        echo "  all          : Run all tests with real DB"
        echo ""
        echo "⚠️  IMPORTANT: Make sure DATABASE_URL points to a development database!"
        echo ""
        echo "Examples:"
        echo "  export DATABASE_URL='postgresql://user:pass@localhost:5432/platziflix_dev'"
        echo "  $0 integration"
        echo ""
        exit 1
        ;;
esac

echo ""
echo "✅ Tests completed!" 