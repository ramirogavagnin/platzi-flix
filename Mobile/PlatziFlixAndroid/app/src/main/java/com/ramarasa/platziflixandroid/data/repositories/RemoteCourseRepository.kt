package com.ramarasa.platziflixandroid.data.repositories

import com.ramarasa.platziflixandroid.data.api.CourseApiService
import com.ramarasa.platziflixandroid.data.mappers.CourseMapper
import com.ramarasa.platziflixandroid.domain.models.Course
import com.ramarasa.platziflixandroid.domain.repositories.CourseRepository
import com.ramarasa.platziflixandroid.di.NetworkConfig
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

/**
 * Remote repository implementation for course operations.
 * Implements the CourseRepository interface and handles API communication.
 */
class RemoteCourseRepository(
    private val apiService: CourseApiService
) : CourseRepository {
    
    override suspend fun getCourses(): Flow<Result<List<Course>>> = flow {
        try {
            val courseDtos = apiService.getCourses()
            val courses = CourseMapper.toDomainList(courseDtos)
            emit(Result.success(courses))
        } catch (exception: Exception) {
            val errorMessage = when {
                exception.message?.contains("Failed to connect") == true -> 
                    "Error de conexión: No se pudo conectar al servidor. Verifica que el servidor esté ejecutándose en ${NetworkConfig.getBaseUrl()}"
                exception.message?.contains("timeout") == true -> 
                    "Error de timeout: La conexión tardó demasiado en responder"
                exception.message?.contains("404") == true -> 
                    "Error 404: El endpoint no fue encontrado"
                exception.message?.contains("500") == true -> 
                    "Error del servidor: Problema interno del servidor"
                else -> "Error desconocido: ${exception.message}"
            }
            emit(Result.failure(Exception(errorMessage)))
        }
    }
    
    override suspend fun getCourseById(id: Int): Flow<Result<Course>> = flow {
        try {
            val courseDto = apiService.getCourseById(id)
            val course = CourseMapper.toDomain(courseDto)
            emit(Result.success(course))
        } catch (exception: Exception) {
            val errorMessage = when {
                exception.message?.contains("Failed to connect") == true -> 
                    "Error de conexión: No se pudo conectar al servidor. Verifica que el servidor esté ejecutándose en ${NetworkConfig.getBaseUrl()}"
                exception.message?.contains("timeout") == true -> 
                    "Error de timeout: La conexión tardó demasiado en responder"
                exception.message?.contains("404") == true -> 
                    "Error 404: El curso con ID $id no fue encontrado"
                exception.message?.contains("500") == true -> 
                    "Error del servidor: Problema interno del servidor"
                else -> "Error desconocido: ${exception.message}"
            }
            emit(Result.failure(Exception(errorMessage)))
        }
    }
} 