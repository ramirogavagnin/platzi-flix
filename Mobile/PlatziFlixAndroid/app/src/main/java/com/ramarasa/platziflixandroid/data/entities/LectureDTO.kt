package com.ramarasa.platziflixandroid.data.entities

import com.google.gson.annotations.SerializedName

/**
 * Data Transfer Object for Lecture API responses.
 * Maps the JSON structure from the API to our domain model.
 */
data class LectureDTO(
    @SerializedName("id")
    val id: Int,
    
    @SerializedName("course_id")
    val courseId: Int,
    
    @SerializedName("name")
    val name: String,
    
    @SerializedName("description")
    val description: String,
    
    @SerializedName("slug")
    val slug: String,
    
    @SerializedName("video_url")
    val videoUrl: String,
    
    @SerializedName("created_at")
    val createdAt: String,
    
    @SerializedName("updated_at")
    val updatedAt: String,
    
    @SerializedName("deleted_at")
    val deletedAt: String?
) 