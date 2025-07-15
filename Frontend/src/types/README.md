# Tipos TypeScript - Platziflix Frontend

Este directorio contiene todos los tipos TypeScript utilizados en el proyecto Platziflix Frontend, basados en los contratos del backend.

## 📁 Estructura de Archivos

```
src/types/
├── index.ts      # Exportaciones principales
├── course.ts     # Tipos para cursos
├── lecture.ts    # Tipos para clases/lecturas
├── teacher.ts    # Tipos para profesores
├── api.ts        # Tipos para respuestas de API
├── common.ts     # Tipos comunes y utilidades
└── README.md     # Esta documentación
```

## 🎯 Tipos Principales

### Course (Curso)

```typescript
import { Course, CourseResponse, CourseDetail } from "@/types";

// Curso completo con todos los campos
const course: Course = {
  id: 1,
  name: "Curso de React",
  description: "Aprende React desde cero",
  thumbnail: "https://via.placeholder.com/150",
  slug: "curso-de-react",
  created_at: "2021-01-01",
  updated_at: "2021-01-01",
  deleted_at: null,
  teacher_id: [1, 2, 3],
};

// Respuesta simplificada para listas
const courseResponse: CourseResponse = {
  id: 1,
  name: "Curso de React",
  description: "Aprende React desde cero",
  thumbnail: "https://via.placeholder.com/150",
  slug: "curso-de-react",
};

// Detalle completo con lectures
const courseDetail: CourseDetail = {
  id: 1,
  name: "Curso de React",
  description: "Aprende React desde cero",
  thumbnail: "https://via.placeholder.com/150",
  slug: "curso-de-react",
  teacher_id: [1, 2, 3],
  lectures: [
    {
      id: 1,
      name: "Clase 1",
      description: "Introducción a React",
      slug: "clase-1",
    },
  ],
};
```

### Lecture (Clase)

```typescript
import { Lecture, LectureResponse, LectureListItem } from "@/types";

// Clase completa
const lecture: Lecture = {
  id: 1,
  course_id: 1,
  name: "Clase 1",
  description: "Introducción a React",
  slug: "clase-1",
  video_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  created_at: "2021-01-01",
  updated_at: "2021-01-01",
  deleted_at: null,
};

// Respuesta de API
const lectureResponse: LectureResponse = {
  id: 1,
  name: "Clase 1",
  description: "Introducción a React",
  slug: "clase-1",
  video_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  created_at: "2021-01-01",
  updated_at: "2021-01-01",
};

// Item para listas
const lectureItem: LectureListItem = {
  id: 1,
  name: "Clase 1",
  description: "Introducción a React",
  slug: "clase-1",
};
```

### Teacher (Profesor)

```typescript
import { Teacher, TeacherResponse } from "@/types";

const teacher: Teacher = {
  id: 1,
  name: "John Doe",
  email: "john.doe@example.com",
  created_at: "2021-01-01",
  updated_at: "2021-01-01",
  deleted_at: null,
};

const teacherResponse: TeacherResponse = {
  id: 1,
  name: "John Doe",
  email: "john.doe@example.com",
  created_at: "2021-01-01",
  updated_at: "2021-01-01",
};
```

## 🔌 Tipos de API

### Respuestas de API

```typescript
import { ApiResponse, GetCoursesResponse, ApiError } from "@/types";

// Respuesta exitosa
const coursesResponse: GetCoursesResponse = {
  data: [
    {
      id: 1,
      name: "Curso de React",
      description: "Aprende React desde cero",
      thumbnail: "https://via.placeholder.com/150",
      slug: "curso-de-react",
    },
  ],
  message: "Cursos obtenidos exitosamente",
  success: true,
};

// Error de API
const apiError: ApiError = {
  message: "No se pudo obtener los cursos",
  status: 500,
  details: { reason: "Database connection failed" },
};
```

### Parámetros de URL

```typescript
import { CourseParams, LectureParams } from "@/types";

const courseParams: CourseParams = {
  slug: "curso-de-react",
};

const lectureParams: LectureParams = {
  slug: "curso-de-react",
  id: "1",
};
```

## 🛠️ Tipos Comunes

### Estados de Carga

```typescript
import { LoadingState, FormState } from "@/types";

const loadingState: LoadingState = "loading"; // 'idle' | 'loading' | 'success' | 'error'
const formState: FormState = "submitting"; // 'idle' | 'submitting' | 'success' | 'error'
```

### Componentes Base

```typescript
import { BaseComponentProps, ModalProps } from "@/types";

const MyComponent: React.FC<BaseComponentProps> = ({ className, children }) => {
  return <div className={className}>{children}</div>;
};

const MyModal: React.FC<ModalProps> = ({
  isOpen,
  onClose,
  title,
  children,
}) => {
  if (!isOpen) return null;
  return (
    <div>
      <h2>{title}</h2>
      {children}
      <button onClick={onClose}>Cerrar</button>
    </div>
  );
};
```

### Notificaciones

```typescript
import { Notification, NotificationType } from "@/types";

const notification: Notification = {
  id: "1",
  type: "success",
  title: "Éxito",
  message: "Curso creado correctamente",
  duration: 5000,
};
```

## 📝 Uso en Componentes

### Ejemplo de Hook con Tipos

```typescript
import { useState, useEffect } from "react";
import { Course, LoadingState, ApiError } from "@/types";

interface UseCoursesReturn {
  courses: Course[];
  loading: LoadingState;
  error: ApiError | null;
}

export const useCourses = (): UseCoursesReturn => {
  const [courses, setCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState<LoadingState>("idle");
  const [error, setError] = useState<ApiError | null>(null);

  useEffect(() => {
    setLoading("loading");
    // Lógica de fetch...
  }, []);

  return { courses, loading, error };
};
```

### Ejemplo de Componente con Tipos

```typescript
import React from "react";
import { Course, BaseComponentProps } from "@/types";

interface CourseCardProps extends BaseComponentProps {
  course: Course;
  onSelect: (course: Course) => void;
}

export const CourseCard: React.FC<CourseCardProps> = ({
  course,
  onSelect,
  className,
}) => {
  return (
    <div className={className} onClick={() => onSelect(course)}>
      <img src={course.thumbnail} alt={course.name} />
      <h3>{course.name}</h3>
      <p>{course.description}</p>
    </div>
  );
};
```

## 🔄 Actualización de Tipos

Cuando se actualicen los contratos del backend, actualiza los tipos correspondientes en este directorio. Mantén la consistencia entre:

1. **Tipos de entidad** (Course, Lecture, Teacher)
2. **Tipos de respuesta** (CourseResponse, LectureResponse, etc.)
3. **Tipos de API** (GetCoursesResponse, etc.)
4. **Tipos de formulario** (CourseFormData, etc.)

## 📚 Recursos

- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Next.js TypeScript](https://nextjs.org/docs/basic-features/typescript)
- [Contratos del Backend](../Backend/specs/00_contracts.md)
