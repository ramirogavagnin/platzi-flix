# Guía para Ejecutar Tests Individuales

Esta guía te muestra todas las formas de ejecutar tests específicos del archivo `test_courses.py`.

## 📋 Lista de Tests Disponibles

### GET /courses
```
test_courses.py::TestGetCourses::test_get_courses_success
test_courses.py::TestGetCourses::test_get_courses_empty_list
test_courses.py::TestGetCourses::test_get_courses_contract_compliance
test_courses.py::TestGetCourses::test_get_courses_service_error
```

### GET /courses/{slug}
```
test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_success
test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_not_found
test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_contract_compliance
test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_service_error
test_courses.py::TestGetCourseBySlug::test_get_course_by_slug_special_characters
```

## 🚀 Método 1: Script Conveniente (Recomendado)

### Usar el script `run_single_test.sh`:

```bash
# Ver ayuda
./run_single_test.sh

# Ejecutar tests específicos
./run_single_test.sh success           # Test de éxito para /courses
./run_single_test.sh empty             # Test de lista vacía
./run_single_test.sh contract          # Tests de cumplimiento de contrato
./run_single_test.sh error             # Tests de manejo de errores
./run_single_test.sh slug_success      # Test de éxito para /courses/{slug}
./run_single_test.sh slug_not_found    # Test de 404
./run_single_test.sh slug_contract     # Test de contrato para slug
./run_single_test.sh slug_error        # Test de error para slug
./run_single_test.sh slug_special      # Test de caracteres especiales
./run_single_test.sh all               # Todos los tests
```

## 🎯 Método 2: Comando directo de pytest

### Ejecutar un test específico:

```bash
# Configurar variable de entorno
export DATABASE_URL=sqlite:///./test.db

# Ejecutar test específico
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v

# Ejecutar test con información detallada
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v -s
```

### Ejecutar una clase completa:

```bash
# Todos los tests de GET /courses
python -m pytest test_courses.py::TestGetCourses -v

# Todos los tests de GET /courses/{slug}
python -m pytest test_courses.py::TestGetCourseBySlug -v
```

## 🔍 Método 3: Filtros por patrones

### Usar el flag `-k` para filtrar:

```bash
# Ejecutar todos los tests que contienen "success"
python -m pytest test_courses.py -k "success" -v

# Ejecutar todos los tests que contienen "error"
python -m pytest test_courses.py -k "error" -v

# Ejecutar todos los tests que contienen "contract"
python -m pytest test_courses.py -k "contract" -v

# Ejecutar tests que contienen "slug" y "success"
python -m pytest test_courses.py -k "slug and success" -v

# Ejecutar tests que NO contienen "error"
python -m pytest test_courses.py -k "not error" -v
```

## 🛠️ Método 4: Opciones avanzadas

### Con información detallada:

```bash
# Mostrar output completo
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v -s

# Mostrar solo tests fallidos
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v --tb=short

# Parar en el primer fallo
python -m pytest test_courses.py -x

# Mostrar las primeras 3 líneas de cada test
python -m pytest test_courses.py --tb=line
```

### Con timing:

```bash
# Mostrar tiempos de ejecución
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v --durations=10

# Mostrar los tests más lentos
python -m pytest test_courses.py -v --durations=0
```

## 🎨 Método 5: Desde VS Code/IDEs

### En VS Code:
1. Abre el archivo `test_courses.py`
2. Busca el ícono de "play" ▶️ junto al nombre del test
3. Clic derecho → "Run Test" o "Debug Test"

### En PyCharm:
1. Abre el archivo `test_courses.py`
2. Clic derecho en el nombre del test
3. Selecciona "Run 'test_name'" o "Debug 'test_name'"

## 🏃‍♂️ Ejemplos Prácticos

### Desarrollo típico:

```bash
# 1. Ejecutar un test específico mientras desarrollas
./run_single_test.sh success

# 2. Verificar que el contrato se cumple
./run_single_test.sh contract

# 3. Probar manejo de errores
./run_single_test.sh error

# 4. Ejecutar todos los tests al final
./run_single_test.sh all
```

### Debugging:

```bash
# Ejecutar con máxima información
DATABASE_URL=sqlite:///./test.db python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v -s --tb=long

# Ejecutar y parar en el primer error
DATABASE_URL=sqlite:///./test.db python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v -x
```

## 📝 Notas Importantes

- **Siempre configura**: `DATABASE_URL=sqlite:///./test.db` al ejecutar manualmente
- **El script `run_single_test.sh`** ya incluye la configuración automáticamente
- **Para debugging**: usa `-s` para ver prints y `-v` para información detallada
- **Tests independientes**: cada test se ejecuta de forma aislada
- **Limpieza automática**: los mocks se limpian automáticamente después de cada test

## 💡 Consejos

1. **Usa el script** `run_single_test.sh` para comandos rápidos
2. **Usa pytest directo** para opciones avanzadas
3. **Usa filtros** `-k` para ejecutar grupos de tests
4. **Usa tu IDE** para debugging interactivo
5. **Combina opciones** para análisis detallado 