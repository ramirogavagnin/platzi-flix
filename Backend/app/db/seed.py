"""
Database seeding script for development data.
This script populates the database with sample data for testing and development.
"""

import asyncio
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.core.config import get_settings
from app.db.models import Teacher, Course, Lecture, CourseTeacher


def create_sample_data():
    """Create sample data for development."""
    settings = get_settings()
    
    # Create database engine and session
    engine = create_engine(settings.DATABASE_URL)
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    
    with SessionLocal() as session:
        # Clear existing data (for development only)
        print("🗑️  Clearing existing data...")
        session.query(CourseTeacher).delete()
        session.query(Lecture).delete()
        session.query(Course).delete()
        session.query(Teacher).delete()
        session.commit()
        
        # Create Teachers
        print("👨‍🏫 Creating teachers...")
        teachers_data = [
            {
                "name": "Juan Pérez",
                "email": "juan.perez@platzi.com"
            },
            {
                "name": "María González",
                "email": "maria.gonzalez@platzi.com"
            },
            {
                "name": "Carlos Rodríguez",
                "email": "carlos.rodriguez@platzi.com"
            },
            {
                "name": "Ana Martínez",
                "email": "ana.martinez@platzi.com"
            },
            {
                "name": "David López",
                "email": "david.lopez@platzi.com"
            }
        ]
        
        teachers = []
        for teacher_data in teachers_data:
            teacher = Teacher(**teacher_data)
            session.add(teacher)
            teachers.append(teacher)
        
        session.commit()
        print(f"✅ Created {len(teachers)} teachers")
        
        # Create Courses
        print("📚 Creating courses...")
        courses_data = [
            {
                "name": "Curso de React",
                "description": "Aprende React desde cero hasta convertirte en un experto. Domina componentes, hooks, estado y más.",
                "thumbnail": "https://static.platzi.com/media/achievements/badge-react-2018.png",
                "slug": "curso-de-react"
            },
            {
                "name": "Curso de Python",
                "description": "Domina Python desde los fundamentos hasta conceptos avanzados. Ideal para principiantes y desarrolladores.",
                "thumbnail": "https://static.platzi.com/media/achievements/badge-python.png",
                "slug": "curso-de-python"
            },
            {
                "name": "Curso de JavaScript",
                "description": "Aprende JavaScript moderno, ES6+, programación funcional y desarrollo web frontend.",
                "thumbnail": "https://static.platzi.com/media/achievements/badge-javascript.png",
                "slug": "curso-de-javascript"
            },
            {
                "name": "Curso de Node.js",
                "description": "Desarrolla aplicaciones backend con Node.js, Express y bases de datos.",
                "thumbnail": "https://static.platzi.com/media/achievements/badge-nodejs.png",
                "slug": "curso-de-nodejs"
            },
            {
                "name": "Curso de FastAPI",
                "description": "Crea APIs modernas y eficientes con FastAPI, el framework Python más rápido.",
                "thumbnail": "https://static.platzi.com/media/achievements/badge-fastapi.png",
                "slug": "curso-de-fastapi"
            }
        ]
        
        courses = []
        for course_data in courses_data:
            course = Course(**course_data)
            session.add(course)
            courses.append(course)
        
        session.commit()
        print(f"✅ Created {len(courses)} courses")
        
        # Create Course-Teacher relationships
        print("🔗 Creating course-teacher relationships...")
        course_teacher_relations = [
            (courses[0], teachers[0]),  # React - Juan Pérez
            (courses[0], teachers[1]),  # React - María González
            (courses[1], teachers[2]),  # Python - Carlos Rodríguez
            (courses[1], teachers[4]),  # Python - David López
            (courses[2], teachers[0]),  # JavaScript - Juan Pérez
            (courses[2], teachers[3]),  # JavaScript - Ana Martínez
            (courses[3], teachers[1]),  # Node.js - María González
            (courses[3], teachers[4]),  # Node.js - David López
            (courses[4], teachers[2]),  # FastAPI - Carlos Rodríguez
            (courses[4], teachers[3]),  # FastAPI - Ana Martínez
        ]
        
        for course, teacher in course_teacher_relations:
            course_teacher = CourseTeacher(course_id=course.id, teacher_id=teacher.id)
            session.add(course_teacher)
        
        session.commit()
        print(f"✅ Created {len(course_teacher_relations)} course-teacher relationships")
        
        # Create Lectures
        print("🎥 Creating lectures...")
        lectures_data = [
            # React Course Lectures
            {
                "course_id": courses[0].id,
                "name": "Introducción a React",
                "description": "Conoce qué es React y por qué es tan popular en el desarrollo frontend.",
                "slug": "introduccion-a-react",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            {
                "course_id": courses[0].id,
                "name": "Componentes y JSX",
                "description": "Aprende a crear componentes y usar JSX en React.",
                "slug": "componentes-y-jsx",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            {
                "course_id": courses[0].id,
                "name": "Hooks en React",
                "description": "Domina useState, useEffect y otros hooks esenciales.",
                "slug": "hooks-en-react",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            
            # Python Course Lectures
            {
                "course_id": courses[1].id,
                "name": "Introducción a Python",
                "description": "Primeros pasos con Python, instalación y configuración.",
                "slug": "introduccion-a-python",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            {
                "course_id": courses[1].id,
                "name": "Variables y Tipos de Datos",
                "description": "Aprende sobre variables, números, strings y listas en Python.",
                "slug": "variables-y-tipos-de-datos",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            {
                "course_id": courses[1].id,
                "name": "Funciones en Python",
                "description": "Crea y usa funciones para organizar tu código Python.",
                "slug": "funciones-en-python",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            
            # JavaScript Course Lectures
            {
                "course_id": courses[2].id,
                "name": "Fundamentos de JavaScript",
                "description": "Aprende los conceptos básicos de JavaScript moderno.",
                "slug": "fundamentos-de-javascript",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            {
                "course_id": courses[2].id,
                "name": "ES6 y Arrow Functions",
                "description": "Domina las características modernas de JavaScript ES6+.",
                "slug": "es6-y-arrow-functions",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            
            # Node.js Course Lectures
            {
                "course_id": courses[3].id,
                "name": "Introducción a Node.js",
                "description": "Configura tu entorno de desarrollo con Node.js.",
                "slug": "introduccion-a-nodejs",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            {
                "course_id": courses[3].id,
                "name": "Express y Routing",
                "description": "Crea tu primera API con Express y maneja rutas.",
                "slug": "express-y-routing",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            
            # FastAPI Course Lectures
            {
                "course_id": courses[4].id,
                "name": "Introducción a FastAPI",
                "description": "Conoce FastAPI y sus ventajas sobre otros frameworks.",
                "slug": "introduccion-a-fastapi",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            },
            {
                "course_id": courses[4].id,
                "name": "Pydantic y Validación",
                "description": "Aprende a validar datos con Pydantic en FastAPI.",
                "slug": "pydantic-y-validacion",
                "video_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
            }
        ]
        
        lectures = []
        for lecture_data in lectures_data:
            lecture = Lecture(**lecture_data)
            session.add(lecture)
            lectures.append(lecture)
        
        session.commit()
        print(f"✅ Created {len(lectures)} lectures")
        
        print("🎉 Database seeding completed successfully!")
        print(f"📊 Summary:")
        print(f"   - {len(teachers)} teachers")
        print(f"   - {len(courses)} courses")
        print(f"   - {len(lectures)} lectures")
        print(f"   - {len(course_teacher_relations)} course-teacher relationships")


if __name__ == "__main__":
    create_sample_data() 