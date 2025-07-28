# Configuración de Red para PlatziFlix Android

## Problema Resuelto

El error `HTTP FAILED: java.net.ConnectException: Failed to connect to localhost/127.0.0.1:8000` ocurre porque Android no puede conectarse a `localhost` de tu computadora.

## Soluciones Implementadas

### 1. Configuración Flexible de Entornos

Se creó `NetworkConfig.kt` que permite cambiar fácilmente entre diferentes entornos:

- **Emulador**: `http://10.0.2.2:8000/` (apunta a localhost de tu computadora)
- **Dispositivo Físico**: `http://192.168.8.246:8000/` (IP real de tu máquina)
- **Producción**: `https://api.platziflix.com/`

### 2. Mejor Manejo de Errores

Se mejoró el manejo de errores en `RemoteCourseRepository.kt` para proporcionar mensajes más claros y útiles.

## Cómo Configurar tu Entorno

### Para Emulador Android (Recomendado para desarrollo)

1. Asegúrate de que tu servidor esté ejecutándose en `localhost:8000`
2. En `NetworkConfig.kt`, verifica que `currentEnvironment = Environment.EMULATOR`
3. La URL `10.0.2.2:8000` apunta automáticamente a `localhost:8000` de tu computadora

### Para Dispositivo Físico

1. Encuentra la IP de tu computadora:

   - **macOS/Linux**: `ifconfig` o `ip addr`
   - **Windows**: `ipconfig`

2. Asegúrate de que tu dispositivo y computadora estén en la misma red WiFi

3. Cambia el entorno en `NetworkConfig.kt`:

   ```kotlin
   private var currentEnvironment = Environment.DEVICE
   ```

4. La IP ya está configurada en `getBaseUrl()`:
   ```kotlin
   Environment.DEVICE -> "http://192.168.8.246:8000/"
   ```

### Cambio Dinámico de Entorno

También puedes cambiar el entorno dinámicamente usando `EnvironmentHelper`:

```kotlin
// Para emulador
EnvironmentHelper.switchEnvironment(NetworkConfig.Environment.EMULATOR)

// Para dispositivo físico
EnvironmentHelper.switchEnvironment(NetworkConfig.Environment.DEVICE)

// Para producción
EnvironmentHelper.switchEnvironment(NetworkConfig.Environment.PRODUCTION)
```

### Para Producción

1. En `NetworkConfig.kt`:
   ```kotlin
   private val currentEnvironment = Environment.PRODUCTION
   ```

## Verificación

1. Asegúrate de que tu servidor esté ejecutándose
2. Verifica que puedas acceder a la API desde tu navegador
3. Ejecuta la aplicación Android
4. Revisa los logs para ver la URL que se está usando

## Troubleshooting

### Error de Conexión

- Verifica que el servidor esté ejecutándose
- Confirma que la IP/URL sea correcta
- Asegúrate de que el puerto 8000 esté abierto

### Error de Timeout

- Verifica la conectividad de red
- Aumenta los timeouts en `NetworkModule.kt` si es necesario

### Error 404

- Verifica que los endpoints de la API existan
- Confirma que la URL base sea correcta

## Archivos Modificados

- `app/src/main/java/com/ramarasa/platziflixandroid/di/NetworkModule.kt`
- `app/src/main/java/com/ramarasa/platziflixandroid/di/NetworkConfig.kt` (nuevo)
- `app/src/main/java/com/ramarasa/platziflixandroid/di/EnvironmentHelper.kt` (nuevo)
- `app/src/main/java/com/ramarasa/platziflixandroid/data/repositories/RemoteCourseRepository.kt`

## Estado Actual

✅ **Servidor verificado**: Ejecutándose en `localhost:8000`  
✅ **API verificada**: Endpoint `/courses` responde correctamente  
✅ **IP configurada**: `192.168.8.246:8000` para dispositivos físicos  
✅ **Configuración flexible**: Cambio dinámico entre entornos  
✅ **Manejo de errores mejorado**: Mensajes claros y útiles
