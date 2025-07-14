# 🚀 Cómo Ejecutar Tests desde app/tests/

## 📍 **Ubicación Actual**
Todos los archivos relacionados con testing están ahora en `app/tests/`:
- Scripts de ejecución
- Archivos de configuración
- Documentación
- Tests

## 🔧 **Métodos de Ejecución**

### 1. **Desde app/tests/ (Recomendado)**
```bash
# Navegar a la carpeta de tests
cd app/tests/

# Ejecutar scripts
./run_tests.sh
./run_single_test.sh success
./run_tests_by_type.sh unit
./run_real_data_tests.sh all
./run_tests_with_real_db.sh unit

# Ejecutar pytest directamente
python -m pytest test_courses.py -v
python -m pytest test_courses_real_data.py -v
```

### 2. **Desde la raíz del proyecto**
```bash
# Navegar a la carpeta de tests y ejecutar
cd app/tests && ./run_tests.sh

# O ejecutar pytest con ruta completa
python -m pytest app/tests/test_courses.py -v
python -m pytest app/tests/test_courses_real_data.py -v
```

### 3. **Usando pytest con configuración**
```bash
# Desde app/tests/ (usando pytest.ini local)
cd app/tests/
python -m pytest -v

# Test específico
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v

# Con filtros
python -m pytest test_courses.py -k "success" -v
```

## 📋 **Scripts Disponibles**

Todos ubicados en `app/tests/`:

| Script | Descripción |
|--------|-------------|
| `run_tests.sh` | Ejecuta todos los tests |
| `run_single_test.sh` | Ejecuta un test específico |
| `run_tests_by_type.sh` | Ejecuta por tipo (unit/integration/all) |
| `run_real_data_tests.sh` | Tests con datos reales |
| `run_tests_with_real_db.sh` | Tests con base de datos real |

## 🎯 **Ejemplos Rápidos**

```bash
# Cambiar a directorio de tests
cd app/tests/

# Tests unitarios rápidos
./run_tests_by_type.sh unit

# Test individual
./run_single_test.sh success

# Todos los tests
./run_tests.sh

# Tests con datos reales
./run_real_data_tests.sh all
```

## 🔍 **Debugging**

```bash
# Desde app/tests/
python -m pytest test_courses.py::TestGetCourses::test_get_courses_success -v -s

# Con traceback completo
python -m pytest test_courses.py -v --tb=long

# Parar en primer error
python -m pytest test_courses.py -x
```

## 💡 **Tip**
Para mayor comodidad, puedes crear un alias:
```bash
# Agregar a ~/.bashrc o ~/.zshrc
alias test-courses='cd /ruta/a/tu/proyecto/app/tests && ./run_tests.sh'
``` 