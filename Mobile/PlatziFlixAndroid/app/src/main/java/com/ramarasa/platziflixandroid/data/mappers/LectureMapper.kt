package com.ramarasa.platziflixandroid.data.mappers

import com.ramarasa.platziflixandroid.data.entities.LectureDTO
import com.ramarasa.platziflixandroid.domain.models.Lecture

/**
 * Mapper class to convert between LectureDTO and Lecture domain models.
 * Follows the CLEAR architecture principles for data layer transformations.
 */
object LectureMapper {
    
    /**
     * Converts a LectureDTO to a Lecture domain model.
     * 
     * @param dto The data transfer object from the API
     * @return The domain model representation
     */
    fun toDomain(dto: LectureDTO): Lecture {
        return Lecture(
            id = dto.id,
            courseId = dto.courseId,
            name = dto.name,
            description = dto.description,
            slug = dto.slug,
            videoUrl = dto.videoUrl,
            createdAt = dto.createdAt,
            updatedAt = dto.updatedAt,
            deletedAt = dto.deletedAt
        )
    }
    
    /**
     * Converts a list of LectureDTO to a list of Lecture domain models.
     * 
     * @param dtos The list of data transfer objects from the API
     * @return The list of domain model representations
     */
    fun toDomainList(dtos: List<LectureDTO>): List<Lecture> {
        return dtos.map { toDomain(it) }
    }
} 