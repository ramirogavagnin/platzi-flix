package com.ramarasa.platziflixandroid.domain.repositories

import com.ramarasa.platziflixandroid.domain.models.Course
import kotlinx.coroutines.flow.Flow

/**
 * Repository interface for course operations.
 * Defines the contract for data operations following the CLEAR architecture.
 */
interface CourseRepository {
    /**
     * Retrieves all available courses.
     * @return Flow of list of courses
     */
    suspend fun getCourses(): Flow<Result<List<Course>>>
    
    /**
     * Retrieves a specific course by its ID.
     * @param id The course ID
     * @return Flow of course result
     */
    suspend fun getCourseById(id: Int): Flow<Result<Course>>
} 