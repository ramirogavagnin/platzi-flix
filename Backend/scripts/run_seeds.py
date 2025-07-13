#!/usr/bin/env python3
"""
Script to run database seeds.
This script can be used to populate the database with sample data.
"""

import sys
import os

# Add the parent directory to Python path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app.db.seed import create_sample_data

if __name__ == "__main__":
    print("🌱 Running database seeds...")
    try:
        create_sample_data()
        print("✅ Seeds executed successfully!")
    except Exception as e:
        print(f"❌ Error running seeds: {e}")
        sys.exit(1) 