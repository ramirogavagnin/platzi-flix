#!/bin/bash
# Script to run unit tests for Platziflix Course API

echo "🧪 Running Platziflix Course API Tests"
echo "========================================"

# Use SQLite for testing to avoid PostgreSQL dependency
export DATABASE_URL=sqlite:///./test.db

# Run all tests
python -m pytest test_courses.py -v

echo ""
echo "✅ All tests completed!"
echo "Note: Tests are using SQLite database to avoid PostgreSQL connection requirements" 