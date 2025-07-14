# Tests de Integración - Platziflix Course API

Esta documentación explica los tests de integración que se han agregado al proyecto, cómo funcionan y cómo ejecutarlos.

## 🔍 Diferencias entre Unit Tests e Integration Tests

### Unit Tests (Pruebas Unitarias)
- **Qué prueban**: Lógica del endpoint aislada
- **Dependencias**: Usa **mocks** del CourseService
- **Base de datos**: **NO** se conecta a la base de datos
- **Velocidad**: **Rápidos** (0.2-0.3 segundos)
- **Propósito**: Verificar que el endpoint maneja correctamente las respuestas del servicio

### Integration Tests (Pruebas de Integración)
- **Qué prueban**: Flujo completo endpoint → servicio → base de datos
- **Dependencias**: Usa el **CourseService real**
- **Base de datos**: **SÍ** se conecta a una base de datos SQLite de prueba
- **Velocidad**: **Más lentos** (0.5-0.8 segundos)
- **Propósito**: Verificar que todo el stack funciona correctamente

## 📊 Resumen de Tests

### Unit Tests: **9 tests**
- `TestGetCourses`: 4 tests con mocks
- `TestGetCourseBySlug`: 5 tests con mocks

### Integration Tests: **10 tests**
- `TestGetCoursesIntegration`: 4 tests con DB real
- `TestGetCourseBySlugIntegration`: 6 tests con DB real

### **Total: 19 tests**

## 🗂️ Tests de Integración Implementados

### GET /courses (TestGetCoursesIntegration)

#### ✅ `test_get_courses_success_integration`
- **Propósito**: Verificar que se retornen cursos reales desde la DB
- **Datos**: 2 cursos con teachers y lectures
- **Validaciones**: Estructura de datos, campos requeridos, contenido

#### ✅ `test_get_courses_empty_list_integration`
- **Propósito**: Verificar comportamiento cuando no hay cursos en la DB
- **Datos**: Base de datos vacía
- **Validaciones**: Respuesta 200 con array vacío

#### ✅ `test_get_courses_contract_compliance_integration`
- **Propósito**: Verificar cumplimiento del contrato con datos reales
- **Datos**: 2 cursos completos
- **Validaciones**: Tipos de datos, campos obligatorios

#### ✅ `test_get_courses_soft_delete_integration`
- **Propósito**: Verificar que cursos soft-deleted no aparezcan
- **Datos**: 2 cursos, 1 se elimina suavemente
- **Validaciones**: Solo 1 curso en respuesta

### GET /courses/{slug} (TestGetCourseBySlugIntegration)

#### ✅ `test_get_course_by_slug_success_integration`
- **Propósito**: Verificar retorno de curso completo por slug
- **Datos**: Curso con 2 teachers y 2 lectures
- **Validaciones**: Estructura completa, relaciones correctas

#### ✅ `test_get_course_by_slug_not_found_integration`
- **Propósito**: Verificar respuesta 404 para curso inexistente
- **Datos**: Búsqueda de slug no existente
- **Validaciones**: Status 404, mensaje de error

#### ✅ `test_get_course_by_slug_contract_compliance_integration`
- **Propósito**: Verificar cumplimiento del contrato con datos reales
- **Datos**: Curso completo con relaciones
- **Validaciones**: Estructura de teachers como objetos {id, name}

#### ✅ `test_get_course_by_slug_soft_delete_integration`
- **Propósito**: Verificar que cursos soft-deleted retornen 404
- **Datos**: Curso que se elimina suavemente
- **Validaciones**: Status 404

#### ✅ `test_get_course_by_slug_soft_delete_teachers_integration`
- **Propósito**: Verificar que teachers soft-deleted no aparezcan
- **Datos**: Curso con 2 teachers, 1 se elimina suavemente
- **Validaciones**: Solo 1 teacher en respuesta

#### ✅ `test_get_course_by_slug_soft_delete_lectures_integration`
- **Propósito**: Verificar que lectures soft-deleted no aparezcan
- **Datos**: Curso con 2 lectures, 1 se elimina suavemente
- **Validaciones**: Solo 1 lecture en respuesta

## 🛠️ Configuración de Tests de Integración

### Base de Datos de Prueba
```python
TEST_DATABASE_URL = "sqlite:///./test_integration.db"
```

### Fixtures Principales

#### `db_session`
- Crea tablas de prueba en SQLite
- Configura el override de dependencias
- Limpia la base de datos después de cada test

#### `db_data`
- Crea datos de prueba completos:
  - 3 teachers
  - 2 courses
  - 3 lectures
  - Relaciones course-teacher

### Limpieza Automática
- Cada test ejecuta en una base de datos limpia
- Se eliminan todas las tablas después de cada test
- No hay interferencia entre tests

## 🚀 Cómo Ejecutar los Tests

### Método 1: Por Tipo (Recomendado)
```bash
# Solo tests unitarios (rápidos)
./run_tests_by_type.sh unit

# Solo tests de integración
./run_tests_by_type.sh integration

# Todos los tests
./run_tests_by_type.sh all
```

### Método 2: Tests Específicos
```bash
# Test de integración específico
./run_single_test.sh int_success

# Test de soft delete
./run_single_test.sh int_soft_delete

# Test de slug con DB real
./run_single_test.sh int_slug_success
```

### Método 3: Comando Directo
```bash
# Todos los tests de integración
DATABASE_URL=sqlite:///./test.db python -m pytest test_courses.py::TestGetCoursesIntegration test_courses.py::TestGetCourseBySlugIntegration -v

# Test específico
DATABASE_URL=sqlite:///./test.db python -m pytest test_courses.py::TestGetCoursesIntegration::test_get_courses_success_integration -v
```

## 🎯 Estrategia de Testing

### Durante el Desarrollo
1. **Primero**: Ejecutar unit tests (rápidos)
2. **Después**: Ejecutar integration tests (confirmar funcionalidad completa)
3. **Antes de commit**: Ejecutar todos los tests

### Para CI/CD
```bash
# Tests rápidos para feedback inmediato
./run_tests_by_type.sh unit

# Tests completos para validación final
./run_tests_by_type.sh all
```

## 📋 Verificaciones de los Integration Tests

### Contratos de API
- ✅ Estructura de respuesta correcta
- ✅ Tipos de datos apropiados
- ✅ Campos obligatorios presentes
- ✅ Teachers como objetos `{id, name}` (no solo IDs)

### Funcionalidad de Base de Datos
- ✅ Queries reales funcionan
- ✅ Relaciones se cargan correctamente
- ✅ Soft delete funciona en todos los niveles
- ✅ Filtros de `deleted_at` funcionan

### Casos Edge
- ✅ Cursos sin teachers
- ✅ Cursos sin lectures
- ✅ Búsquedas de cursos inexistentes
- ✅ Soft delete de entidades relacionadas

## 🔄 Flujo de Datos en Integration Tests

```
Test → FastAPI Endpoint → CourseService → SQLAlchemy → SQLite DB
                                    ↓
                           Respuesta Real ← Datos Reales
```

## 💡 Beneficios de los Integration Tests

1. **Confianza**: Verifican que el sistema completo funciona
2. **Detección temprana**: Encuentran errores de integración
3. **Validación de contratos**: Confirman que la API cumple especificaciones
4. **Regresión**: Detectan cambios que rompen funcionalidad existente
5. **Documentación**: Sirven como ejemplos de uso real

## 📝 Notas Importantes

- Los integration tests usan SQLite para simplicidad
- Cada test es completamente independiente
- Los datos se crean fresh para cada test
- Los tests son determinísticos y repetibles
- Se ejecutan en paralelo con los unit tests

## 🚨 Troubleshooting

### Si los tests fallan:
1. Verificar que SQLite esté disponible
2. Revisar que los modelos estén correctamente importados
3. Confirmar que las fixtures estén configuradas
4. Ejecutar tests individuales para debugging

### Para debugging:
```bash
# Con output detallado
DATABASE_URL=sqlite:///./test.db python -m pytest test_courses.py::TestGetCoursesIntegration::test_get_courses_success_integration -v -s

# Con parada en primer error
DATABASE_URL=sqlite:///./test.db python -m pytest test_courses.py::TestGetCoursesIntegration -v -x
``` 