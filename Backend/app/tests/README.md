# Platziflix Course API - Tests

Este directorio contiene las pruebas unitarias para la API de cursos de Platziflix.

## Estructura

```
tests/
├── __init__.py
├── test_courses.py        # Pruebas para los endpoints de cursos
└── README.md             # Este archivo
```

## Pruebas Implementadas

### 🧪 Unit Tests (con mocks) - 9 tests

#### GET /courses
- ✅ **test_get_courses_success**: Verifica que se retorne la lista de cursos correctamente
- ✅ **test_get_courses_empty_list**: Verifica que se retorne una lista vacía cuando no hay cursos
- ✅ **test_get_courses_contract_compliance**: Verifica que la respuesta cumple con el contrato de la API
- ✅ **test_get_courses_service_error**: Verifica que los errores del servicio se manejen correctamente

#### GET /courses/{slug}
- ✅ **test_get_course_by_slug_success**: Verifica que se retorne el curso por slug correctamente
- ✅ **test_get_course_by_slug_not_found**: Verifica que retorne 404 cuando no se encuentra el curso
- ✅ **test_get_course_by_slug_contract_compliance**: Verifica que la respuesta cumple con el contrato
- ✅ **test_get_course_by_slug_service_error**: Verifica que los errores del servicio se manejen correctamente
- ✅ **test_get_course_by_slug_special_characters**: Verifica que funcione con caracteres especiales

### 🗄️ Integration Tests (con DB real) - 10 tests

#### GET /courses (TestGetCoursesIntegration)
- ✅ **test_get_courses_success_integration**: Lista de cursos desde base de datos real
- ✅ **test_get_courses_empty_list_integration**: Comportamiento con base de datos vacía
- ✅ **test_get_courses_contract_compliance_integration**: Contrato con datos reales
- ✅ **test_get_courses_soft_delete_integration**: Soft delete de cursos

#### GET /courses/{slug} (TestGetCourseBySlugIntegration)
- ✅ **test_get_course_by_slug_success_integration**: Curso por slug desde base de datos real
- ✅ **test_get_course_by_slug_not_found_integration**: 404 con base de datos real
- ✅ **test_get_course_by_slug_contract_compliance_integration**: Contrato con datos reales
- ✅ **test_get_course_by_slug_soft_delete_integration**: Soft delete de cursos
- ✅ **test_get_course_by_slug_soft_delete_teachers_integration**: Soft delete de teachers
- ✅ **test_get_course_by_slug_soft_delete_lectures_integration**: Soft delete de lectures

### **Total: 19 tests**

### 🗄️ Real Data Tests (con datos reales de tu DB) - 7 tests

#### Verificación con Datos Reales (TestCoursesWithRealData)
- ✅ **test_get_courses_real_data**: Lista de cursos con tus datos reales
- ✅ **test_get_course_by_slug_real_data**: Detalle de curso con datos reales
- ✅ **test_get_course_by_nonexistent_slug_real_data**: Test 404 con datos reales
- ✅ **test_courses_contract_compliance_real_data**: Contratos con datos reales
- ✅ **test_multiple_course_slugs_real_data**: Múltiples slugs reales

#### Calidad de Datos (TestCourseDataQuality)
- ✅ **test_no_duplicate_slugs**: Verificar slugs únicos en tu DB
- ✅ **test_courses_have_basic_data**: Verificar calidad de datos

### **Total con Real Data: 26 tests**

## Cómo ejecutar las pruebas

### Opción 1: Usando el script (Recomendado)

```bash
./run_tests.sh
```

### Opción 2: Ejecutar por tipo de test

```bash
# Solo tests unitarios (rápidos, con mocks)
./run_tests_by_type.sh unit

# Solo tests de integración (con base de datos real)
./run_tests_by_type.sh integration

# Todos los tests
./run_tests_by_type.sh all
```

### Opción 3: Ejecutar tests con datos REALES de tu base de datos

```bash
# Configurar tu base de datos
export DATABASE_URL='postgresql://user:password@localhost:5432/platziflix'

# Tests con datos reales (RECOMENDADO)
./run_real_data_tests.sh courses      # Lista de cursos reales
./run_real_data_tests.sh slug         # Detalle de curso real
./run_real_data_tests.sh quality      # Calidad de datos
./run_real_data_tests.sh contracts    # Verificar contratos
./run_real_data_tests.sh all          # Todos los tests
```

### Opción 4: Ejecutar tests individuales

```bash
# Tests unitarios
./run_single_test.sh success           # Test específico
./run_single_test.sh contract          # Tests de contrato
./run_single_test.sh slug_success      # Test de slug

# Tests de integración
./run_single_test.sh int_success       # Test de integración
./run_single_test.sh int_soft_delete   # Test de soft delete
./run_single_test.sh int_slug_success  # Test de slug con DB

# Ver ayuda completa
./run_single_test.sh                   
```

### Opción 3: Manualmente

```bash
# Configurar la base de datos para pruebas
export DATABASE_URL=sqlite:///./test.db

# Ejecutar todas las pruebas
python -m pytest test_courses.py -v

# Ejecutar una prueba específica
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v

# Ejecutar por patrones
python -m pytest test_courses.py -k "success" -v
```

### 📖 Guías Completas

- **Tests individuales**: `tests/SINGLE_TEST_GUIDE.md` - Cómo ejecutar tests específicos
- **Tests de integración**: `tests/INTEGRATION_TESTS.md` - Diferencias entre unit e integration tests
- **Tests con datos reales**: `tests/REAL_DATA_TESTS.md` - Cómo usar datos reales de tu base de datos

## Características de las pruebas

### 🧪 Unit Tests (Pruebas Unitarias)

- **CourseService**: Se usa mock para simular el servicio sin depender de la base de datos
- **Dependency Injection**: Se utiliza `app.dependency_overrides` para reemplazar la dependencia real
- **Velocidad**: Rápidos (0.2-0.3 segundos)
- **Propósito**: Verificar lógica de endpoints aisladamente

### 🗄️ Integration Tests (Pruebas de Integración)

- **Base de datos real**: Se conecta a SQLite de prueba
- **Flujo completo**: Endpoint → Service → Database → Respuesta
- **Fixtures**: Datos de prueba creados automáticamente
- **Limpieza**: Base de datos se limpia después de cada test
- **Velocidad**: Más lentos (0.5-0.8 segundos)
- **Propósito**: Verificar que todo el sistema funciona correctamente

### 🗄️ Real Data Tests (Pruebas con Datos Reales)

- **Base de datos real**: Se conecta a TU base de datos (PostgreSQL/SQLite)
- **Datos reales**: Usa los datos que tienes en tu base de datos
- **Sin fixtures**: No crea datos, usa los existentes
- **Calidad de datos**: Verifica que tus datos cumplen los contratos
- **Velocidad**: Variable (depende de tu base de datos)
- **Propósito**: Verificar que tu API funciona con datos reales

### Validación de Contratos

Las pruebas verifican que las respuestas cumplan con el contrato definido en `specs/00_contracts.md`:

#### GET /courses
```json
[
  {
    "id": 1,
    "name": "Curso de React",
    "description": "Curso de React",
    "thumbnail": "https://via.placeholder.com/150",
    "slug": "curso-de-react"
  }
]
```

#### GET /courses/{slug}
```json
{
  "id": 1,
  "name": "Curso de React",
  "description": "Curso de React",
  "thumbnail": "https://via.placeholder.com/150",
  "slug": "curso-de-react",
  "teacher_id": [1, 2, 3],
  "lectures": [
    {
      "id": 1,
      "name": "Clase 1",
      "description": "Clase 1",
      "slug": "clase-1"
    }
  ]
}
```

## Dependencias

Las pruebas requieren las siguientes dependencias:

```bash
pip install pytest fastapi httpx sqlalchemy pydantic-settings
```

## Notas

- Las pruebas utilizan SQLite para evitar dependencias de PostgreSQL
- Se utilizan fixtures de pytest para configurar datos de prueba
- Las pruebas son independientes y no modifican el estado de la aplicación
- Se verifica tanto el comportamiento correcto como el manejo de errores 