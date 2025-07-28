package com.ramarasa.platziflixandroid.di

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities

/**
 * Configuración de red para diferentes entornos de desarrollo
 */
object NetworkConfig {
    
    enum class Environment {
        EMULATOR,
        DEVICE,
        PRODUCTION
    }
    
    private var currentEnvironment = Environment.EMULATOR // Cambia según tu entorno
    
    fun setEnvironment(environment: Environment) {
        currentEnvironment = environment
    }
    
    fun getBaseUrl(): String {
        return when (currentEnvironment) {
            Environment.EMULATOR -> "http://10.0.2.2:8000/"
            Environment.DEVICE -> "http://192.168.8.246:8000/" // IP real de tu máquina
            Environment.PRODUCTION -> "https://api.platziflix.com/"
        }
    }
    
    fun isNetworkAvailable(context: Context): Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork ?: return false
        val activeNetwork = connectivityManager.getNetworkCapabilities(network) ?: return false
        
        return when {
            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
            else -> false
        }
    }
    
    fun getEnvironmentName(): String {
        return when (currentEnvironment) {
            Environment.EMULATOR -> "Emulador"
            Environment.DEVICE -> "Dispositivo Físico"
            Environment.PRODUCTION -> "Producción"
        }
    }
} 