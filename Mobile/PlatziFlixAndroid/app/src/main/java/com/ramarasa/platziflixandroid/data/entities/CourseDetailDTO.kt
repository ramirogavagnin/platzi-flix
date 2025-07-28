package com.ramarasa.platziflixandroid.data.entities

import com.google.gson.annotations.JsonAdapter
import com.google.gson.annotations.SerializedName

/**
 * Data Transfer Object for Course Detail API responses.
 * Maps the JSON structure from the API to our domain model.
 */
data class CourseDetailDTO(
    @SerializedName("id")
    val id: Int,
    
    @SerializedName("name")
    val name: String,
    
    @SerializedName("description")
    val description: String,
    
    @SerializedName("thumbnail")
    val thumbnail: String,
    
    @SerializedName("slug")
    val slug: String,
    
    @SerializedName("teacher_id")
    @JsonAdapter(TeacherIdDeserializer::class)
    val teacherIds: List<Int> = emptyList(),
    
    @SerializedName("classes")
    val lectures: List<LectureDTO>
) {
    /**
     * Fallback constructor for cases where teacher_id might be missing or malformed
     */
    constructor(
        id: Int,
        name: String,
        description: String,
        thumbnail: String,
        slug: String,
        lectures: List<LectureDTO>
    ) : this(id, name, description, thumbnail, slug, emptyList(), lectures)
} 