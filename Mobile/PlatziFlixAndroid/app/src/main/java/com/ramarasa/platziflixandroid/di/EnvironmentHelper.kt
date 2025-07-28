package com.ramarasa.platziflixandroid.di

import android.util.Log

/**
 * Helper para facilitar el cambio de entorno de desarrollo
 */
object EnvironmentHelper {
    
    private const val TAG = "EnvironmentHelper"
    
    /**
     * Cambia el entorno de desarrollo
     * @param environment El entorno a usar
     */
    fun switchEnvironment(environment: NetworkConfig.Environment) {
        NetworkConfig.setEnvironment(environment)
        Log.i(TAG, "Cambiando entorno a: ${environment.name}")
        Log.i(TAG, "URL base: ${NetworkConfig.getBaseUrl()}")
        
        when (environment) {
            NetworkConfig.Environment.EMULATOR -> {
                Log.i(TAG, "Configurado para emulador Android")
                Log.i(TAG, "Asegúrate de que tu servidor esté ejecutándose en localhost:8000")
            }
            NetworkConfig.Environment.DEVICE -> {
                Log.i(TAG, "Configurado para dispositivo físico")
                Log.i(TAG, "Asegúrate de que tu dispositivo y computadora estén en la misma red WiFi")
            }
            NetworkConfig.Environment.PRODUCTION -> {
                Log.i(TAG, "Configurado para producción")
                Log.i(TAG, "Usando API de producción")
            }
        }
    }
    
    /**
     * Obtiene información del entorno actual
     */
    fun getEnvironmentInfo(): String {
        return """
            Entorno: ${NetworkConfig.getEnvironmentName()}
            URL Base: ${NetworkConfig.getBaseUrl()}
            Servidor: ${if (NetworkConfig.getBaseUrl().contains("10.0.2.2")) "localhost:8000" else NetworkConfig.getBaseUrl()}
        """.trimIndent()
    }
} 