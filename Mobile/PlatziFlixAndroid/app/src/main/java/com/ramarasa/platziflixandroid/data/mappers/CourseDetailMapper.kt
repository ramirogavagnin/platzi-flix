package com.ramarasa.platziflixandroid.data.mappers

import com.ramarasa.platziflixandroid.data.entities.CourseDetailDTO
import com.ramarasa.platziflixandroid.domain.models.CourseDetail

/**
 * Mapper class to convert between CourseDetailDTO and CourseDetail domain models.
 * Follows the CLEAR architecture principles for data layer transformations.
 */
object CourseDetailMapper {
    
    /**
     * Converts a CourseDetailDTO to a CourseDetail domain model.
     * 
     * @param dto The data transfer object from the API
     * @return The domain model representation
     */
    fun toDomain(dto: CourseDetailDTO): CourseDetail {
        return CourseDetail(
            id = dto.id,
            name = dto.name,
            description = dto.description,
            thumbnail = dto.thumbnail,
            slug = dto.slug,
            teacherIds = dto.teacherIds,
            lectures = LectureMapper.toDomainList(dto.lectures)
        )
    }
} 