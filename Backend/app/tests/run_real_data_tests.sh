#!/bin/bash
# Script to run tests with REAL DATA from your database

export DATABASE_URL=${DATABASE_URL:-"postgresql://user:password@localhost:5432/platziflix"}

echo "🗄️ Real Data Tests - Platziflix Course API"
echo "=========================================="
echo ""
echo "These tests will use REAL data from your database:"
echo "📊 Database: $DATABASE_URL"
echo ""

case $1 in
    "quality")
        echo "🔍 Running Data Quality Tests"
        echo "=============================="
        python -m pytest test_courses_real_data.py::TestCourseDataQuality -v -s
        ;;
    "contracts")
        echo "📋 Testing API Contracts with Real Data"
        echo "========================================"
        python -m pytest test_courses_real_data.py::TestCoursesWithRealData::test_courses_contract_compliance_real_data -v -s
        ;;
    "courses")
        echo "📋 Testing GET /courses with Real Data"
        echo "======================================"
        python -m pytest test_courses_real_data.py::TestCoursesWithRealData::test_get_courses_real_data -v -s
        ;;
    "slug")
        echo "🎯 Testing GET /courses/{slug} with Real Data"
        echo "============================================="
        python -m pytest test_courses_real_data.py::TestCoursesWithRealData::test_get_course_by_slug_real_data -v -s
        ;;
    "multiple")
        echo "🧪 Testing Multiple Real Slugs"
        echo "=============================="
        python -m pytest test_courses_real_data.py::TestCoursesWithRealData::test_multiple_course_slugs_real_data -v -s
        ;;
    "all")
        echo "🧪 Running ALL Real Data Tests"
        echo "=============================="
        python -m pytest test_courses_real_data.py -v -s
        ;;
    *)
        echo "Usage: $0 <test_type>"
        echo ""
        echo "Available test types:"
        echo ""
        echo "  courses    : Test GET /courses endpoint with real data"
        echo "  slug       : Test GET /courses/{slug} endpoint with real data"
        echo "  multiple   : Test multiple course slugs from your database"
        echo "  contracts  : Verify API contracts with real data"
        echo "  quality    : Check data quality in your database"
        echo "  all        : Run all real data tests"
        echo ""
        echo "Examples:"
        echo "  $0 courses     # Test courses list with your real data"
        echo "  $0 slug        # Test course detail with your real data"
        echo "  $0 quality     # Check data quality in your database"
        echo ""
        echo "💡 Make sure your DATABASE_URL is set correctly:"
        echo "   export DATABASE_URL='postgresql://user:pass@localhost:5432/platziflix'"
        echo ""
        exit 1
        ;;
esac 