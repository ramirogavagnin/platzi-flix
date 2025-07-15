# Platzi Flix Frontend

Proyecto frontend para Platzi Flix construido con Next.js 15 y SCSS para la gestión de estilos.

## 🚀 Tecnologías

- **Next.js 15** - Framework de React con App Router
- **TypeScript** - Tipado estático para JavaScript
- **SCSS/Sass** - Preprocesador de CSS para gestión avanzada de estilos
- **Tailwind CSS** - Framework de utilidades CSS
- **ESLint** - Linter para mantener calidad de código

## 📁 Estructura del Proyecto

```
Frontend/
├── src/
│   ├── app/                 # App Router de Next.js
│   │   ├── layout.tsx      # Layout principal
│   │   └── page.tsx        # Página de inicio
│   └── styles/             # Archivos SCSS
│       ├── globals.scss    # Estilos globales principales
│       ├── reset.scss      # Reset de CSS para normalizar navegadores
│       └── vars.scss       # Variables SCSS (colores, tipografía, etc.)
├── public/                 # Archivos estáticos
├── package.json
└── README.md
```

## 🎨 Sistema de Estilos

### Archivos SCSS

#### `src/styles/vars.scss`

Contiene todas las variables del proyecto:

- **Colores**: Paleta de colores principal y neutrales
- **Tipografía**: Familias de fuentes, tamaños y pesos
- **Espaciado**: Sistema de espaciado consistente
- **Breakpoints**: Puntos de quiebre para responsive design
- **Sombras**: Sistema de sombras
- **Transiciones**: Configuración de animaciones
- **Z-index**: Sistema de capas

#### `src/styles/reset.scss`

Normaliza los estilos predeterminados de los navegadores:

- Reset de márgenes y padding
- Box-sizing consistente
- Normalización de formularios
- Optimización de imágenes
- Soporte para preferencias de movimiento reducido

#### `src/styles/globals.scss`

Archivo principal que:

- Importa variables y reset
- Define estilos globales
- Proporciona clases de utilidad
- Configura responsive design

## 🛠️ Comandos Disponibles

```bash
# Instalar dependencias
npm install

# Ejecutar en modo desarrollo
npm run dev

# Construir para producción
npm run build

# Ejecutar en modo producción
npm run start

# Ejecutar linter
npm run lint
```

## 🎯 Características

- ✅ **Next.js 15** con App Router
- ✅ **TypeScript** para tipado estático
- ✅ **SCSS** para gestión avanzada de estilos
- ✅ **CSS Reset** para normalización de navegadores
- ✅ **Sistema de variables** para consistencia de diseño
- ✅ **Clases de utilidad** para desarrollo rápido
- ✅ **Responsive design** con breakpoints predefinidos
- ✅ **ESLint** para calidad de código
- ✅ **Tailwind CSS** para utilidades adicionales

## 📝 Uso de Variables SCSS

```scss
// Importar variables en cualquier archivo SCSS
@import "../styles/vars";

.my-component {
  color: $primary-color;
  font-size: $font-size-lg;
  padding: $spacing-md;
  border-radius: $border-radius-lg;

  @media (min-width: $breakpoint-md) {
    font-size: $font-size-xl;
  }
}
```

## 🔧 Configuración

El proyecto está configurado para usar:

- **App Router** de Next.js 15
- **SCSS** automáticamente soportado por Next.js
- **TypeScript** para mejor DX
- **ESLint** con configuración de Next.js
- **Tailwind CSS** para utilidades adicionales

## 🚀 Desarrollo

1. Clona el repositorio
2. Instala las dependencias: `npm install`
3. Ejecuta el servidor de desarrollo: `npm run dev`
4. Abre [http://localhost:3000](http://localhost:3000) en tu navegador

## 📚 Recursos

- [Next.js Documentation](https://nextjs.org/docs)
- [SCSS Documentation](https://sass-lang.com/documentation)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [TypeScript Documentation](https://www.typescriptlang.org/docs)
