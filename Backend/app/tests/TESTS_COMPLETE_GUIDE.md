# 🧪 Guía Completa de Testing - Platziflix Course API

Esta es la **guía definitiva** para ejecutar tests en Platziflix. Tienes **3 tipos de tests** disponibles.

## 📊 **Resumen de Tests Disponibles**

| Tipo de Test | Cantidad | Base de Datos | Datos | Velocidad | Propósito |
|--------------|----------|---------------|-------|-----------|-----------|
| **Unit Tests** | 9 tests | No usa | Mocks | 0.2s | Verificar lógica |
| **Integration Tests** | 10 tests | SQLite temporal | Datos ficticios | 0.5s | Verificar flujo completo |
| **Real Data Tests** | 7 tests | **Tu base de datos** | **Datos reales** | Variable | Verificar con datos reales |
| **Total** | **26 tests** | - | - | - | - |

## 🚀 **Cómo Ejecutar Tests**

### **1. Tests Unitarios (Rápidos, con mocks)**
```bash
# Ejecutar solo unit tests
./run_tests_by_type.sh unit

# Tests específicos
./run_single_test.sh success
./run_single_test.sh contract
./run_single_test.sh slug_success
```

### **2. Tests de Integración (Con base de datos temporal)**
```bash
# Ejecutar solo integration tests
./run_tests_by_type.sh integration

# Tests específicos
./run_single_test.sh int_success
./run_single_test.sh int_soft_delete
./run_single_test.sh int_slug_success
```

### **3. Tests con Datos Reales (Con TU base de datos)** ⭐
```bash
# Configurar tu base de datos
export DATABASE_URL='postgresql://user:password@localhost:5432/platziflix'

# Ejecutar tests con datos reales
./run_real_data_tests.sh courses      # Lista de cursos reales
./run_real_data_tests.sh slug         # Detalle de curso real
./run_real_data_tests.sh quality      # Calidad de datos
./run_real_data_tests.sh contracts    # Verificar contratos
./run_real_data_tests.sh all          # Todos los tests
```

### **4. Todos los Tests**
```bash
# Todos los tests (unit + integration)
./run_tests_by_type.sh all

# Todos los tests incluyendo datos reales
export DATABASE_URL='tu_url'
./run_tests_by_type.sh all && ./run_real_data_tests.sh all
```

## 🎯 **Cuándo Usar Cada Tipo**

### **Durante el Desarrollo** 🛠️
```bash
# Feedback rápido mientras programas
./run_tests_by_type.sh unit
```

### **Verificación de Funcionalidad** ✅
```bash
# Verificar que todo funciona
./run_tests_by_type.sh integration
```

### **Validación con Datos Reales** 🗄️
```bash
# Verificar que funciona con TUS datos
export DATABASE_URL='postgresql://user:pass@localhost:5432/platziflix_dev'
./run_real_data_tests.sh all
```

### **Antes de Commit** 📝
```bash
# Ejecutar todo para estar seguro
./run_tests_by_type.sh all
```

## 📋 **Tests Detallados**

### **Unit Tests (9 tests) - con mocks**
```
TestGetCourses (4 tests):
├── test_get_courses_success
├── test_get_courses_empty_list
├── test_get_courses_contract_compliance
└── test_get_courses_service_error

TestGetCourseBySlug (5 tests):
├── test_get_course_by_slug_success
├── test_get_course_by_slug_not_found
├── test_get_course_by_slug_contract_compliance
├── test_get_course_by_slug_service_error
└── test_get_course_by_slug_special_characters
```

### **Integration Tests (10 tests) - con base de datos temporal**
```
TestGetCoursesIntegration (4 tests):
├── test_get_courses_success_integration
├── test_get_courses_empty_list_integration
├── test_get_courses_contract_compliance_integration
└── test_get_courses_soft_delete_integration

TestGetCourseBySlugIntegration (6 tests):
├── test_get_course_by_slug_success_integration
├── test_get_course_by_slug_not_found_integration
├── test_get_course_by_slug_contract_compliance_integration
├── test_get_course_by_slug_soft_delete_integration
├── test_get_course_by_slug_soft_delete_teachers_integration
└── test_get_course_by_slug_soft_delete_lectures_integration
```

### **Real Data Tests (7 tests) - con TUS datos reales**
```
TestCoursesWithRealData (5 tests):
├── test_get_courses_real_data
├── test_get_course_by_slug_real_data
├── test_get_course_by_nonexistent_slug_real_data
├── test_courses_contract_compliance_real_data
└── test_multiple_course_slugs_real_data

TestCourseDataQuality (2 tests):
├── test_no_duplicate_slugs
└── test_courses_have_basic_data
```

## 📊 **Outputs de Ejemplo**

### **Unit Tests**
```bash
$ ./run_tests_by_type.sh unit
🧪 Running Unit Tests (with mocks)
=================================
collected 9 items
9 passed, 0 failed (0.23s)
```

### **Integration Tests**
```bash
$ ./run_tests_by_type.sh integration
🧪 Running Integration Tests (with real DB)
===========================================
collected 10 items
10 passed, 0 failed (0.55s)
```

### **Real Data Tests**
```bash
$ ./run_real_data_tests.sh courses
🗄️ Real Data Tests - Platziflix Course API
==========================================
📊 Found 15 courses in database
📋 Course 1: Curso de React (slug: curso-de-react)
📋 Course 2: Curso de Python (slug: curso-de-python)
PASSED
```

## 🛠️ **Configuración por Entorno**

### **Desarrollo Local**
```bash
# Unit tests para desarrollo rápido
./run_tests_by_type.sh unit

# Integration tests para verificación
./run_tests_by_type.sh integration
```

### **Con Base de Datos de Desarrollo**
```bash
export DATABASE_URL='postgresql://dev_user:dev_pass@localhost:5432/platziflix_dev'
./run_real_data_tests.sh all
```

### **Con Docker**
```bash
export DATABASE_URL='postgresql://platziflix_user:platziflix_password@db:5432/platziflix'
./run_real_data_tests.sh all
```

## ⚠️ **Consideraciones Importantes**

### **Para Real Data Tests**
- ⚠️ **NUNCA** uses base de datos de producción
- ✅ Usa base de datos de desarrollo o staging
- 📊 Los resultados dependen de tus datos reales
- 🔄 Si no hay datos, algunos tests se saltan automáticamente

### **Performance**
- 🚀 Unit tests: Más rápidos (0.2s)
- 🔄 Integration tests: Medianos (0.5s)
- 🐌 Real data tests: Variables (depende de tu DB)

## 💡 **Flujo de Trabajo Recomendado**

### **Desarrollo Diario**
```bash
# 1. Cambios de código
./run_tests_by_type.sh unit

# 2. Nueva funcionalidad
./run_tests_by_type.sh integration

# 3. Validación final
export DATABASE_URL='tu_url_dev'
./run_real_data_tests.sh all
```

### **CI/CD Pipeline**
```bash
# Stage 1: Tests rápidos
./run_tests_by_type.sh unit

# Stage 2: Tests completos
./run_tests_by_type.sh integration

# Stage 3: Validación con staging data
export DATABASE_URL='staging_url'
./run_real_data_tests.sh all
```

## 📖 **Documentación Adicional**

- **Tests individuales**: `SINGLE_TEST_GUIDE.md`
- **Tests de integración**: `INTEGRATION_TESTS.md`
- **Tests con datos reales**: `REAL_DATA_TESTS.md`
- **README general**: `README.md`

## 🎉 **Resumen Final**

✅ **26 tests** que cubren todos los aspectos
✅ **3 niveles** de testing: unit, integration, real data
✅ **Scripts convenientes** para todos los casos de uso
✅ **Documentación completa** para el equipo
✅ **Flexibility total** para diferentes entornos

¡Tu API está **completamente testeada** y lista para producción! 🚀 