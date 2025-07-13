# 🌱 Database Seeds

Este proyecto incluye un sistema de seeds para poblar la base de datos con datos de desarrollo.

## 📋 Contenido de los Seeds

Los seeds incluyen:

- **5 Teachers** (Profesores)
- **5 Courses** (Cursos)
- **12 Lectures** (Clases)
- **10 Course-Teacher relationships** (Relaciones entre cursos y profesores)

### 👨‍🏫 Profesores

- Juan Pérez
- María González
- Carlos Rodríguez
- Ana Martínez
- David López

### 📚 Cursos

- Curso de React
- Curso de Python
- Curso de JavaScript
- Curso de Node.js
- Curso de FastAPI

### 🎥 Clases

Cada curso tiene entre 2-3 clases con contenido específico.

## 🚀 Ejecución Automática

### Durante la construcción de Docker

Los seeds se ejecutan automáticamente cuando se construye la imagen de Docker:

```bash
# Al iniciar el entorno de desarrollo
make start
```

Esto ejecutará:

1. **Migraciones** de base de datos
2. **Seeds** de datos de desarrollo

### Servicio de inicialización

El `docker-compose.yml` incluye un servicio `db-init` que:

- Espera a que la base de datos esté lista
- Ejecuta las migraciones de Alembic
- Ejecuta los seeds
- Se completa y permite que el API inicie

## 🔧 Ejecución Manual

### Ejecutar seeds manualmente

```bash
# Ejecutar seeds usando el script Python
make seed

# Ejecutar seeds usando el script bash
make seed-only
```

### Ejecutar migraciones

```bash
# Ejecutar migraciones de base de datos
make migrate
```

### Ejecutar script de inicialización completo

```bash
# Ejecutar migraciones + seeds
docker-compose exec api ./scripts/init_db.sh
```

## 📁 Archivos Relacionados

- `app/db/seed.py` - Script principal de seeds
- `scripts/run_seeds.py` - Script de ejecución
- `scripts/init_db.sh` - Script de inicialización completa
- `scripts/seed_only.sh` - Script solo para seeds
- `docker-compose.yml` - Configuración del servicio de inicialización

## ⚠️ Importante

- Los seeds están diseñados para **desarrollo** únicamente
- **Limpian los datos existentes** antes de insertar nuevos datos
- No usar en producción
- Los datos se recrean cada vez que se ejecutan los seeds

## 🔄 Comandos Disponibles

```bash
make start      # Iniciar entorno (incluye migraciones + seeds)
make migrate    # Solo migraciones
make seed       # Solo seeds (Python)
make seed-only  # Solo seeds (Bash)
make stop       # Detener contenedores
make clean      # Limpiar todo
```

## 📊 Datos de Ejemplo

### Cursos con sus respectivos profesores:

- **React**: Juan Pérez, María González
- **Python**: Carlos Rodríguez, David López
- **JavaScript**: Juan Pérez, Ana Martínez
- **Node.js**: María González, David López
- **FastAPI**: Carlos Rodríguez, Ana Martínez

### URLs de ejemplo:

- `GET /courses` - Lista todos los cursos
- `GET /courses/curso-de-react` - Curso específico
- `GET /courses/curso-de-react/classes/1` - Clase específica

¡Los seeds están listos para usar! 🎉
