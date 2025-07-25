# 📚 Documentación del Proyecto Platzi Flix

Este directorio contiene toda la documentación del proyecto Platzi Flix, incluyendo especificaciones de testing, guías de desarrollo y documentación técnica.

## 📁 Estructura de Documentación

```
src/docs/
├── README.md                    # Este archivo - Índice de documentación
├── features/                    # Especificaciones Gherkin
│   └── video-player.feature    # Documentación de tests del reproductor de video
└── testing/                     # Documentación de testing
    └── README.md               # Guía completa de testing con Playwright
```

## 🧪 Testing y Calidad

### Documentación de Tests con Gherkin

- **[Guía de Testing](./testing/README.md)** - Documentación completa de tests end-to-end
- **[Especificaciones Gherkin](./features/)** - Archivos .feature con escenarios de testing

### Características de Testing

- ✅ **Tests End-to-End** con Playwright
- ✅ **Documentación Gherkin** en español
- ✅ **Escenarios parametrizados** para múltiples cursos
- ✅ **Validación del reproductor de video**
- ✅ **Tests de navegación** y estructura de la aplicación

## 🎯 Funcionalidades Documentadas

### Reproductor de Video

- **Integración con YouTube**: Iframe embebido con controles completos
- **Estados de carga**: Overlay y spinner durante la carga
- **Manejo de errores**: URLs inválidas y mensajes de error
- **Navegación**: Botones de regreso y navegación entre páginas

### Estructura de la Aplicación

- **Página principal**: Lista de cursos disponibles
- **Página de curso**: Detalles y lista de lecciones
- **Página de lección**: Reproductor de video e información

## 🚀 Cómo Usar la Documentación

### Para Desarrolladores

1. **Revisar especificaciones**: Consultar archivos `.feature` para entender requerimientos
2. **Ejecutar tests**: Seguir la guía en `testing/README.md`
3. **Mantener documentación**: Actualizar archivos cuando se modifiquen funcionalidades

### Para QA y Testing

1. **Leer escenarios**: Revisar archivos Gherkin para entender casos de prueba
2. **Ejecutar tests**: Usar Playwright para validar funcionalidades
3. **Reportar bugs**: Documentar problemas encontrados

## 📋 Escenarios de Testing Documentados

### 1. Navegación Completa

- Página principal → Curso → Lección → Reproductor
- Validación de URLs y elementos en cada paso

### 2. Reproductor de Video

- Carga del iframe de YouTube
- Verificación de controles de reproducción
- Estados de carga y transiciones

### 3. Manejo de Errores

- URLs de video inválidas
- Mensajes de error apropiados
- Recuperación de errores

### 4. Navegación de Regreso

- Botón "Volver al curso"
- Persistencia de estado
- Navegación correcta

## 🛠️ Herramientas Utilizadas

- **Playwright**: Framework de testing end-to-end
- **Gherkin/Cucumber**: Sintaxis para documentar escenarios
- **TypeScript**: Implementación de tests
- **SCSS**: Estilos y selectores para tests

## 📖 Convenciones de Documentación

### Archivos Gherkin (.feature)

- **Idioma**: Español
- **Estructura**: Feature → Scenario → Steps
- **Parámetros**: Uso de tablas para datos de prueba

### Archivos de Test (.spec.ts)

- **Framework**: Playwright
- **Idioma**: TypeScript
- **Convenciones**: Nombres descriptivos en español

### Documentación (README.md)

- **Formato**: Markdown
- **Idioma**: Español
- **Estructura**: Clara y organizada

## 🔄 Mantenimiento

### Actualizar Documentación

1. Modificar archivos `.feature` cuando cambien requerimientos
2. Actualizar tests en `.spec.ts` para reflejar cambios
3. Mantener README.md actualizado con nuevas funcionalidades

### Agregar Nuevos Tests

1. Crear archivo `.feature` con escenarios
2. Implementar tests en `.spec.ts`
3. Actualizar documentación correspondiente

## 📞 Contacto y Soporte

Para preguntas sobre la documentación o testing:

- Revisar archivos en este directorio
- Consultar la guía de testing detallada
- Verificar ejemplos en archivos `.feature`

---

**Última actualización**: Diciembre 2024  
**Versión**: 1.0.0  
**Mantenido por**: Equipo de Desarrollo Platzi Flix
