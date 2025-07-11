# Plaztziflix

plataforma online de cursos, cada curso tiene clases y descripciones.

## Stacks

### Frontend

- Typescript
- CSS modules
- SASS

### Mobile

- iOS:
  - Swift
  - SwiftUI
- Android:
  - Kotlin
  - Jetpack Compose

### Backend

- Python
- FastAPI
- PostgreSQL

## Contratos

### Entidades

1. Curso
2. Clases
3. Profesor

### Contratos

- Course

```json
{
  "id": 1,
  "name": "Curso 1",
  "description": "Descripcion del curso 1",
  "thumbnail": "https://www.example.com/thumbnail.jpg",
  "slug": "curso-de-react",
  "created_at": "2023-01-01T00:00:00Z",
  "updated_at": "2023-01-01T00:00:00Z",
  "deleted_at": null,
  "teacher_id": [1, 2, 3]
}
```

- Clases

```json
{
  "id": 1,
  "course_id": 1,
  "name": "Curso 1",
  "description": "Descripcion del curso 1",
  "video_url": "https://www.example.com/video.mp4",
  "created_at": "2023-01-01T00:00:00Z",
  "updated_at": "2023-01-01T00:00:00Z",
  "deleted_at": null
}
```

- Teacher

```json
{
  "id": 1,
  "name": "Profesor 1",
  "email": "profesor1@example.com",
  "created_at": "2023-01-01T00:00:00Z",
  "updated_at": "2023-01-01T00:00:00Z",
  "deleted_at": null
}
```

### Endpoints

- GET /courses -> Listado de cursos

```json
{
  "id": 1,
  "name": "Curso 1",
  "description": "Descripcion del curso 1",
  "thumbnail": "https://www.example.com/thumbnail.jpg",
  "slug": "curso-de-react"
}
```

- GET /courses/:slug -> Obtener un curso

```json
{
  "id": 1,
  "name": "Curso 1",
  "description": "Descripcion del curso 1",
  "thumbnail": "https://www.example.com/thumbnail.jpg",
  "slug": "curso-de-react",
  "teacher_id": [1, 2, 3],
  "classes": [
    {
      "id": 1,
      "name": "Clase 1",
      "description": "Descripcion de la clase 1",
      "slug": "clase-1"
    }
  ]
}
```

- GET /courses/:slug/classes/:id -> Obtener una clase

```json
{
  "id": 1,
  "name": "Clase 1",
  "description": "Descripcion de la   clase 1",
  "slug": "clase-1",
  "video_url": "https://www.example.com/video.mp4",
  "created_at": "2023-01-01T00:00:00Z",
  "updated_at": "2023-01-01T00:00:00Z",
  "deleted_at": null
}
```
