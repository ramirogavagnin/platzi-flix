package com.ramarasa.platziflixandroid.domain.repositories

import com.ramarasa.platziflixandroid.domain.models.CourseDetail

/**
 * Repository interface for course detail operations.
 * Defines the contract for course detail data access operations.
 */
interface CourseDetailRepository {
    
    /**
     * Retrieves course detail by slug.
     * 
     * @param slug The course slug identifier
     * @return CourseDetail domain model
     * @throws Exception if the operation fails
     */
    suspend fun getCourseBySlug(slug: String): CourseDetail
} 