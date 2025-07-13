#!/bin/bash
set -e

echo "🔄 Initializing database..."

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
until pg_isready -h db -p 5432 -U ${POSTGRES_USER:-postgres}; do
    echo "Database is not ready yet. Retrying in 2 seconds..."
    sleep 2
done

echo "✅ Database is ready!"

# Run migrations
echo "🚀 Running database migrations..."
cd app && uv run alembic upgrade head && cd ..

# Run seeds
echo "🌱 Running database seeds..."
uv run python scripts/run_seeds.py

echo "🎉 Database initialization completed!" 