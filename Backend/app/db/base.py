from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from app.core.config import get_settings

settings = get_settings()

# Create SQLAlchemy engine
engine = create_engine(settings.DATABASE_URL)

# Create SessionLocal class for database sessions
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create Base class for declarative models
Base = declarative_base()

# Note: Models will be imported in alembic/env.py for migration discovery
# This avoids circular import issues


def get_db():
    """
    Dependency to get database session.
    Yields a database session and ensures it's properly closed.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close() 