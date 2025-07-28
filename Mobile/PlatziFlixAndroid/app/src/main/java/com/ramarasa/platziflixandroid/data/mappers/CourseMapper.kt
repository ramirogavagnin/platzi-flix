package com.ramarasa.platziflixandroid.data.mappers

import com.ramarasa.platziflixandroid.data.entities.CourseDTO
import com.ramarasa.platziflixandroid.domain.models.Course
import java.text.SimpleDateFormat
import java.util.*

/**
 * Mapper class to convert between CourseDTO and Course domain models.
 * Follows the CLEAR architecture principle of data transformation.
 */
object CourseMapper {
    
    /**
     * Converts a CourseDTO to a Course domain model.
     * @param dto The data transfer object
     * @return The domain model
     */
    fun toDomain(dto: CourseDTO): Course {
        return Course(
            id = dto.id,
            name = dto.name ?: "Sin nombre",
            description = dto.description ?: "Sin descripción",
            thumbnail = dto.thumbnail ?: "",
            slug = dto.slug ?: "",
            createdAt = dto.createdAt ?: getCurrentTimestamp(),
            updatedAt = dto.updatedAt ?: getCurrentTimestamp(),
            deletedAt = dto.deletedAt,
            teacherIds = dto.teacherIds ?: emptyList()
        )
    }
    
    /**
     * Converts a list of CourseDTO to a list of Course domain models.
     * @param dtos The list of data transfer objects
     * @return The list of domain models
     */
    fun toDomainList(dtos: List<CourseDTO>): List<Course> {
        return dtos.map { toDomain(it) }
    }
    
    /**
     * Gets the current timestamp in ISO format as a fallback for null createdAt values.
     * @return Current timestamp string
     */
    private fun getCurrentTimestamp(): String {
        val dateFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault())
        dateFormat.timeZone = TimeZone.getTimeZone("UTC")
        return dateFormat.format(Date())
    }
} 