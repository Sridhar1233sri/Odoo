#!/usr/bin/env python3
"""
Test database connection and create tables
"""
import sys
sys.path.insert(0, '/Users/sridhars/Projects/Odoo/backend')

from app.database import engine, Base
from app.models import User, Trip, Stop, Activity

def init_db():
    """Initialize database tables"""
    try:
        # Create all tables
        print("Creating database tables...")
        Base.metadata.create_all(bind=engine)
        print("✅ Database tables created successfully!")
        
        # Test connection
        with engine.connect() as conn:
            print("✅ Database connection successful!")
            
        return True
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    success = init_db()
    sys.exit(0 if success else 1)
