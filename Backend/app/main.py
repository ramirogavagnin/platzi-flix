from contextlib import asynccontextmanager

from fastapi import Depends, FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import text
from sqlalchemy.orm import Session

from app.core.config import Settings, get_settings
from app.db.base import get_db
from app.services.course_service import CourseService, get_course_service


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan events."""
    # Startup
    settings = get_settings()
    print(f"🚀 Starting {settings.PROJECT_NAME} v{settings.VERSION}")
    print(f"📊 Environment: {settings.ENVIRONMENT}")
    print(f"🔧 Debug mode: {settings.DEBUG}")
    
    yield
    
    # Shutdown
    print(f"👋 Shutting down {settings.PROJECT_NAME}")


# Get settings for app configuration
settings = get_settings()

# Create FastAPI application
app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    description="Plataforma de cursos online Platziflix",
    debug=settings.DEBUG,
    lifespan=lifespan,
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    """Root endpoint with welcome message."""
    return {
        "message": f"Welcome to {settings.PROJECT_NAME}",
        "version": settings.VERSION,
        "environment": settings.ENVIRONMENT,
        "docs": "/docs",
        "health": "/health"
    }


@app.get("/health")
async def health_check():
    """Health check endpoint."""
    return {
        "status": "ok",
        "service": settings.PROJECT_NAME,
        "version": settings.VERSION,
        "environment": settings.ENVIRONMENT
    }


@app.get("/db-test")
async def db_test(db: Session = Depends(get_db)):
    """Test database connection."""
    try:
        # Test database connection by executing a simple query
        result = db.execute(text("SELECT 1 as test")).fetchone()
        return {
            "database": "connected",
            "test_query": result[0],
            "database_url": settings.DATABASE_URL.split("@")[1] if "@" in settings.DATABASE_URL else "hidden"
        }
    except Exception as e:
        return {
            "database": "error",
            "error": str(e)
        }


@app.get("/courses")
async def get_courses(course_service: CourseService = Depends(get_course_service)):
    """Get all courses."""
    try:
        courses = course_service.get_courses()
        return courses
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error fetching courses: {str(e)}")


@app.get("/courses/{slug}")
async def get_course(slug: str, course_service: CourseService = Depends(get_course_service)):
    """Get a course by slug."""
    try:
        course = course_service.get_course_by_slug(slug)
        
        if not course:
            raise HTTPException(status_code=404, detail="Course not found")
        
        return course
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error fetching course: {str(e)}")


@app.get("/lectures/{lecture_id}")
async def get_lecture(lecture_id: int, course_service: CourseService = Depends(get_course_service)):
    """Get a specific lecture by lecture ID."""
    try:
        lecture = course_service.get_lecture_by_id(lecture_id)
        
        if not lecture:
            raise HTTPException(status_code=404, detail="Lecture not found")
        
        return lecture
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error fetching lecture: {str(e)}")


if __name__ == "__main__":
    import uvicorn
    
    uvicorn.run(
        "app.main:app",
        host=settings.HOST,
        port=settings.PORT,
        reload=settings.DEBUG
    ) 