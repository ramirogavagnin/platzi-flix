package com.ramarasa.platziflixandroid.data.entities

import com.google.gson.annotations.SerializedName

/**
 * Data Transfer Object for Course API responses.
 * Represents the raw data structure from the API.
 */
data class CourseDTO(
    @SerializedName("id")
    val id: Int,
    
    @SerializedName("name")
    val name: String?,
    
    @SerializedName("description")
    val description: String?,
    
    @SerializedName("thumbnail")
    val thumbnail: String?,
    
    @SerializedName("slug")
    val slug: String?,
    
    @SerializedName("created_at")
    val createdAt: String?,
    
    @SerializedName("updated_at")
    val updatedAt: String?,
    
    @SerializedName("deleted_at")
    val deletedAt: String?,
    
    @SerializedName("teacher_id")
    val teacherIds: List<Int>?
) 