# Tests con Datos Reales de la Base de Datos

Esta guía explica cómo ejecutar tests usando los **datos reales** de tu base de datos, en lugar de datos ficticios de prueba.

## 🔍 **Diferencias entre Tipos de Tests**

| Tipo de Test | Base de Datos | Datos | Propósito |
|--------------|---------------|-------|-----------|
| **Unit Tests** | No usa | Mocks | Verificar lógica de endpoints |
| **Integration Tests** | SQLite temporal | Datos ficticios | Verificar flujo completo |
| **Real Data Tests** | Tu base de datos | **Datos reales** | Verificar funcionamiento con datos reales |

## 🚀 **Cómo Ejecutar Tests con Datos Reales**

### **1. Configurar Base de Datos**

```bash
# Configurar la URL de tu base de datos
export DATABASE_URL='postgresql://user:password@localhost:5432/platziflix'

# O para base de datos de desarrollo
export DATABASE_URL='postgresql://user:password@localhost:5432/platziflix_dev'
```

### **2. Ejecutar Tests Específicos**

```bash
# Tests con datos reales (RECOMENDADO)
./run_real_data_tests.sh courses     # Lista de cursos reales
./run_real_data_tests.sh slug        # Detalle de curso real
./run_real_data_tests.sh quality     # Calidad de datos
./run_real_data_tests.sh contracts   # Verificar contratos
./run_real_data_tests.sh all         # Todos los tests

# Tests con seguridad adicional
./run_tests_with_real_db.sh integration  # Con confirmación
```

### **3. Comando Directo**

```bash
# Específico
export DATABASE_URL='tu_url_aqui'
python -m pytest test_courses_real_data.py::TestCoursesWithRealData::test_get_courses_real_data -v -s

# Todos
python -m pytest test_courses_real_data.py -v -s
```

## 📋 **Tests Disponibles con Datos Reales**

### **Funcionalidad Básica**

#### ✅ `test_get_courses_real_data`
- **Propósito**: Verificar lista de cursos con datos reales
- **Qué hace**: 
  - Llama a GET /courses
  - Muestra cuántos cursos reales encuentra
  - Lista los primeros 3 cursos
  - Verifica estructura de datos

#### ✅ `test_get_course_by_slug_real_data`
- **Propósito**: Verificar detalle de curso con datos reales
- **Qué hace**:
  - Obtiene lista de cursos reales
  - Toma el primer slug real
  - Llama a GET /courses/{slug}
  - Muestra teachers y lectures reales
  - Verifica estructura completa

#### ✅ `test_multiple_course_slugs_real_data`
- **Propósito**: Probar múltiples cursos reales
- **Qué hace**:
  - Testa los primeros 3 cursos de tu base de datos
  - Verifica que cada slug funcione correctamente

### **Verificación de Contratos**

#### ✅ `test_courses_contract_compliance_real_data`
- **Propósito**: Verificar que TODOS los cursos cumplan el contrato
- **Qué hace**:
  - Revisa cada curso en tu base de datos
  - Verifica campos obligatorios
  - Valida tipos de datos
  - Reporta errores específicos

### **Calidad de Datos**

#### ✅ `test_no_duplicate_slugs`
- **Propósito**: Verificar que no hay slugs duplicados
- **Qué hace**:
  - Cuenta todos los slugs
  - Identifica duplicados si existen
  - Reporta estadísticas

#### ✅ `test_courses_have_basic_data`
- **Propósito**: Verificar que los cursos tengan datos básicos
- **Qué hace**:
  - Revisa campos vacíos o nulos
  - Lista problemas encontrados
  - No falla el test, solo reporta

## 🎯 **Casos de Uso Prácticos**

### **Durante el Desarrollo**
```bash
# Verificar que tu API funciona con datos reales
./run_real_data_tests.sh courses

# Probar un curso específico
./run_real_data_tests.sh slug
```

### **Control de Calidad**
```bash
# Verificar calidad de datos
./run_real_data_tests.sh quality

# Verificar contratos con datos reales
./run_real_data_tests.sh contracts
```

### **Debugging**
```bash
# Ver output detallado de un test específico
export DATABASE_URL='tu_url'
python -m pytest test_courses_real_data.py::TestCoursesWithRealData::test_get_courses_real_data -v -s
```

## 📊 **Ejemplo de Output**

```bash
$ ./run_real_data_tests.sh courses

🗄️ Real Data Tests - Platziflix Course API
==========================================

These tests will use REAL data from your database:
📊 Database: postgresql://user:pass@localhost:5432/platziflix

📋 Testing GET /courses with Real Data
======================================

test_get_courses_real_data 
📊 Found 15 courses in database
📋 Course 1: Curso de React (slug: curso-de-react)
📋 Course 2: Curso de Python (slug: curso-de-python)
📋 Course 3: Curso de JavaScript (slug: curso-de-javascript)
PASSED

✅ Tests completed!
```

## ⚠️ **Consideraciones Importantes**

### **Seguridad**
- ⚠️ **NUNCA uses base de datos de producción**
- ✅ Usa base de datos de desarrollo o staging
- ✅ Haz backup antes de ejecutar tests

### **Performance**
- 🐌 Los tests son más lentos (dependen de tu base de datos)
- 📊 Tiempo depende de cantidad de datos
- 🔄 Los resultados pueden variar según los datos

### **Datos Variables**
- 📊 Los tests se adaptan a tus datos reales
- ✅ Si no hay cursos, los tests se saltan automáticamente
- 📋 Los outputs muestran información real de tu base de datos

## 🔧 **Configuración Avanzada**

### **Variables de Entorno**
```bash
# Base de datos de desarrollo
export DATABASE_URL='postgresql://dev_user:dev_pass@localhost:5432/platziflix_dev'

# Base de datos de staging
export DATABASE_URL='postgresql://staging_user:staging_pass@staging.example.com:5432/platziflix_staging'
```

### **Para Docker**
```bash
# Si usas Docker
export DATABASE_URL='postgresql://platziflix_user:platziflix_password@db:5432/platziflix'
```

## 🚨 **Troubleshooting**

### **Error: No courses found**
- Significa que tu base de datos está vacía
- Los tests se saltarán automáticamente
- Agrega algunos cursos a tu base de datos

### **Error: Database connection**
- Verifica tu DATABASE_URL
- Confirma que la base de datos esté corriendo
- Verifica credenciales y permisos

### **Tests fallan con datos reales**
- Puede indicar problemas en tus datos
- Usa `./run_real_data_tests.sh quality` para diagnosticar
- Revisa los mensajes de error específicos

## 💡 **Recomendaciones**

### **Flujo de Trabajo Sugerido**
1. **Desarrollo**: Usa unit tests para feedback rápido
2. **Funcionalidad**: Usa integration tests para verificar lógica
3. **Validación**: Usa real data tests para verificar con datos reales
4. **Pre-producción**: Ejecuta todos los tests

### **Comandos Útiles**
```bash
# Para desarrollo diario
./run_tests_by_type.sh unit

# Para verificar funcionalidad completa
./run_tests_by_type.sh integration

# Para validar con datos reales
./run_real_data_tests.sh all

# Para debugging específico
./run_real_data_tests.sh quality
```

## 🎉 **Beneficios**

1. **Confianza**: Verificas que tu API funciona con datos reales
2. **Calidad**: Detectas problemas en tus datos
3. **Contratos**: Confirmas que tus datos cumplen el contrato
4. **Debugging**: Identificas problemas específicos de datos
5. **Validación**: Confirmas que todo funciona en tu entorno real 