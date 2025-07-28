package com.ramarasa.platziflixandroid.data.api

import com.ramarasa.platziflixandroid.data.entities.CourseDTO
import com.ramarasa.platziflixandroid.data.entities.CourseDetailDTO
import retrofit2.http.GET
import retrofit2.http.Path

/**
 * API service interface for course-related endpoints.
 * Defines the contract for HTTP operations with the backend.
 */
interface CourseApiService {
    
    /**
     * Retrieves all courses from the API.
     * @return List of course DTOs
     */
    @GET("courses")
    suspend fun getCourses(): List<CourseDTO>
    
    /**
     * Retrieves a specific course by ID.
     * @param id The course ID
     * @return Course DTO
     */
    @GET("courses/{id}")
    suspend fun getCourseById(@Path("id") id: Int): CourseDTO
    
    /**
     * Retrieves a specific course detail by slug.
     * @param slug The course slug
     * @return Course detail DTO with lectures
     */
    @GET("courses/{slug}")
    suspend fun getCourseBySlug(@Path("slug") slug: String): CourseDetailDTO
} 