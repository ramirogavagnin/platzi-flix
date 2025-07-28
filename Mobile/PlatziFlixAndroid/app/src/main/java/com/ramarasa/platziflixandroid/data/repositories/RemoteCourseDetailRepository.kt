package com.ramarasa.platziflixandroid.data.repositories

import android.util.Log
import com.ramarasa.platziflixandroid.data.api.CourseApiService
import com.ramarasa.platziflixandroid.data.mappers.CourseDetailMapper
import com.ramarasa.platziflixandroid.domain.models.CourseDetail
import com.ramarasa.platziflixandroid.domain.repositories.CourseDetailRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

/**
 * Remote repository implementation for course detail operations.
 * Handles API calls and data transformations for course detail functionality.
 */
class RemoteCourseDetailRepository(
    private val apiService: CourseApiService
) : CourseDetailRepository {
    
    companion object {
        private const val TAG = "RemoteCourseDetailRepo"
    }
    
    /**
     * Retrieves course detail by slug from the remote API.
     * 
     * @param slug The course slug identifier
     * @return CourseDetail domain model
     * @throws Exception if the API call fails
     */
    override suspend fun getCourseBySlug(slug: String): CourseDetail {
        return withContext(Dispatchers.IO) {
            try {
                Log.d(TAG, "Fetching course detail for slug: $slug")
                val courseDetailDTO = apiService.getCourseBySlug(slug)
                Log.d(TAG, "Received course detail DTO: $courseDetailDTO")
                
                val courseDetail = CourseDetailMapper.toDomain(courseDetailDTO)
                Log.d(TAG, "Mapped to domain model: $courseDetail")
                
                courseDetail
            } catch (exception: Exception) {
                Log.e(TAG, "Error fetching course detail for slug: $slug", exception)
                throw Exception("Failed to fetch course detail: ${exception.message}")
            }
        }
    }
} 