# Configuración de Alembic para Platziflix

## Estructura de archivos

Los archivos de Alembic están ubicados en:
- `app/alembic.ini` - Archivo de configuración principal
- `app/alembic/` - Directorio con scripts de migración
- `app/alembic/versions/` - Directorio con archivos de migración

## Comandos de Alembic

**IMPORTANTE:** Todos los comandos de Alembic deben ejecutarse desde el directorio `app/`:

```bash
cd app
```

### Comandos básicos:

```bash
# Verificar configuración
uv run alembic check

# Ver migración actual
uv run alembic current

# Ver historial de migraciones
uv run alembic history

# Crear nueva migración
uv run alembic revision --autogenerate -m "Descripción de la migración"

# Aplicar migraciones
uv run alembic upgrade head

# Revertir migraciones
uv run alembic downgrade -1
```

### Configuración de la base de datos

La configuración de la base de datos se obtiene automáticamente desde `app/core/config.py`.

Para cambiar la configuración de la base de datos, crear un archivo `.env` en la raíz del proyecto con:

```env
DATABASE_URL=postgresql://user:password@localhost:5432/platziflix
```

## Próximos pasos

1. Crear los modelos de SQLAlchemy en `app/db/models/`
2. Crear migraciones para las tablas: `teachers`, `courses`, `classes`, `course_teacher`
3. Aplicar las migraciones a la base de datos 