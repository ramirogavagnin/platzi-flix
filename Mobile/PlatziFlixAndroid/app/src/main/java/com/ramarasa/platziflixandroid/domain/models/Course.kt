package com.ramarasa.platziflixandroid.domain.models

/**
 * Domain model representing a course in the application.
 * This is the core business entity that follows the CLEAR architecture principles.
 */
data class Course(
    val id: Int,
    val name: String,
    val description: String,
    val thumbnail: String,
    val slug: String,
    val createdAt: String,
    val updatedAt: String,
    val deletedAt: String?,
    val teacherIds: List<Int>
) 