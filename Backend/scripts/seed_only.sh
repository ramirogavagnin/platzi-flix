#!/bin/bash
set -e

echo "🌱 Running database seeds only..."

# Run seeds
uv run python scripts/run_seeds.py

echo "✅ Seeds completed!" 