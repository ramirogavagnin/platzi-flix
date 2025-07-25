# Documentación de Tests con Gherkin y Playwright

Este directorio contiene la documentación y implementación de tests end-to-end para la funcionalidad del reproductor de video en Platzi Flix, utilizando la sintaxis Gherkin de Cucumber y Playwright como framework de testing.

## Estructura de Archivos

```
src/
├── docs/
│   ├── features/
│   │   └── video-player.feature    # Documentación Gherkin de los escenarios
│   └── testing/
│       └── README.md               # Esta documentación
└── test/
    └── e2e/
        └── video-player.spec.ts    # Implementación de tests con Playwright
```

## Documentación Gherkin

### Archivo: `video-player.feature`

Este archivo documenta los escenarios de testing utilizando la sintaxis Gherkin de Cucumber en español. Incluye:

#### Funcionalidad Principal

- **Funcionalidad**: Reproductor de Video en Cursos
- **Como**: Usuario de Platzi Flix
- **Quiero**: Poder ver videos de las clases
- **Para**: Aprender el contenido del curso

#### Escenarios Documentados

1. **Esquema del Scenario: Navegación al curso y verificación del reproductor**

   - Prueba múltiples cursos con datos parametrizados
   - Verifica la navegación completa desde la página principal hasta el reproductor

2. **Scenario: Verificación del reproductor de video funcional**

   - Valida que el iframe de YouTube se carga correctamente
   - Verifica los controles de reproducción
   - Confirma la URL del video

3. **Scenario: Manejo de errores en el reproductor**

   - Prueba el comportamiento cuando hay URLs inválidas
   - Verifica los mensajes de error apropiados

4. **Scenario: Estados de carga del reproductor**

   - Valida el overlay de carga
   - Verifica la transición de estados de carga

5. **Scenario: Navegación de regreso al curso**
   - Prueba la funcionalidad del botón "Volver al curso"

## Implementación con Playwright

### Archivo: `video-player.spec.ts`

Este archivo implementa los escenarios de Gherkin utilizando Playwright. Cada test corresponde a un escenario del archivo `.feature`.

#### Características de la Implementación

- **Configuración**: Viewport de 1280x720 para mejor visualización
- **Selectores**: Utiliza selectores CSS y de texto para localizar elementos
- **Assertions**: Verifica visibilidad, contenido y URLs
- **Navegación**: Prueba el flujo completo de navegación

#### Tests Implementados

1. **Navegación al curso de React y verificación del reproductor**

   ```typescript
   test("Scenario: Navegación al curso de React y verificación del reproductor", async ({
     page,
   }) => {
     // Implementación del flujo completo
   });
   ```

2. **Verificación del reproductor de video funcional**

   ```typescript
   test("Scenario: Verificación del reproductor de video funcional", async ({
     page,
   }) => {
     // Validación del iframe de YouTube
   });
   ```

3. **Estados de carga del reproductor**

   ```typescript
   test("Scenario: Estados de carga del reproductor", async ({ page }) => {
     // Verificación de estados de carga
   });
   ```

4. **Navegación de regreso al curso**

   ```typescript
   test("Scenario: Navegación de regreso al curso", async ({ page }) => {
     // Prueba del botón de regreso
   });
   ```

5. **Verificación de múltiples cursos**

   ```typescript
   test("Scenario: Verificación de múltiples cursos", async ({ page }) => {
     // Validación de la página principal
   });
   ```

6. **Verificación de la estructura de la página de lección**
   ```typescript
   test("Scenario: Verificación de la estructura de la página de lección", async ({
     page,
   }) => {
     // Validación de la estructura de la página
   });
   ```

## Cómo Ejecutar los Tests

### Prerrequisitos

1. **Servidor de desarrollo ejecutándose**:

   ```bash
   npm run dev
   ```

2. **API backend ejecutándose**:

   ```bash
   # En el directorio del backend
   npm start
   ```

3. **Playwright instalado**:
   ```bash
   npx playwright install
   ```

### Comandos de Ejecución

#### Ejecutar todos los tests

```bash
npx playwright test
```

#### Ejecutar tests específicos

```bash
npx playwright test video-player.spec.ts
```

#### Ejecutar tests en modo UI

```bash
npx playwright test --ui
```

#### Ejecutar tests en modo headed (con navegador visible)

```bash
npx playwright test --headed
```

#### Ejecutar tests en modo debug

```bash
npx playwright test --debug
```

## Estructura de Gherkin

### Elementos Principales

1. **Feature (Funcionalidad)**

   ```gherkin
   Funcionalidad: Nombre de la funcionalidad
     Como [rol del usuario]
     Quiero [objetivo]
     Para [beneficio]
   ```

2. **Background (Contexto)**

   ```gherkin
   Contexto:
     Dado que [condición inicial]
     Y que [otra condición]
   ```

3. **Scenario (Scenario)**

   ```gherkin
   Scenario: Descripción del escenario
     Dado que [condición inicial]
     Cuando [acción]
     Entonces [resultado esperado]
   ```

4. **Scenario Outline (Esquema del Scenario)**
   ```gherkin
   Esquema del Scenario: Descripción
     Dado que [condición]
     Cuando [acción] "<parámetro>"
     Entonces [resultado] "<parámetro>"

     Ejemplos:
       | parámetro1 | parámetro2 |
       | valor1     | valor2     |
   ```

### Palabras Clave en Español

- **Dado que**: Establece el contexto inicial
- **Cuando**: Describe la acción que se realiza
- **Entonces**: Define el resultado esperado
- **Y**: Conecta múltiples pasos del mismo tipo
- **Pero**: Conecta pasos con lógica negativa

## Validaciones Implementadas

### Reproductor de Video

- ✅ **Visibilidad del contenedor**: `.playerContainer`
- ✅ **Iframe de YouTube**: `iframe[src*="youtube.com"]`
- ✅ **URL del video**: Verificación del video ID
- ✅ **Controles de reproducción**: Atributos `allow` y `allowfullscreen`
- ✅ **Estados de carga**: Overlay y spinner de carga

### Navegación

- ✅ **Página principal**: Verificación de elementos principales
- ✅ **Página del curso**: URL y estructura correcta
- ✅ **Página de lección**: URL y elementos de la lección
- ✅ **Botón de regreso**: Funcionalidad de navegación

### Estructura de la Aplicación

- ✅ **Lista de cursos**: Verificación de múltiples cursos
- ✅ **Lista de lecciones**: Estructura de lecciones en el curso
- ✅ **Información de lección**: Título y descripción
- ✅ **Header de lección**: Botón de regreso y navegación

## Casos de Prueba Cubiertos

1. **Flujo Feliz**: Navegación completa y reproducción exitosa
2. **Estados de Carga**: Verificación de loading states
3. **Navegación**: Botones de regreso y navegación entre páginas
4. **Estructura**: Validación de elementos de la interfaz
5. **Múltiples Cursos**: Verificación de diferentes cursos disponibles

## Mejoras Futuras

1. **Tests de Error**: Implementar mocks para probar casos de error
2. **Tests de Accesibilidad**: Validar accesibilidad del reproductor
3. **Tests de Rendimiento**: Medir tiempos de carga
4. **Tests de Responsive**: Verificar comportamiento en diferentes tamaños
5. **Tests de Integración**: Probar con API real

## Notas Técnicas

- Los tests utilizan selectores CSS que corresponden a las clases definidas en los archivos SCSS
- Se verifica la integración con YouTube mediante la validación del iframe
- Los tests son independientes y pueden ejecutarse en cualquier orden
- Se incluyen timeouts apropiados para elementos que requieren carga
