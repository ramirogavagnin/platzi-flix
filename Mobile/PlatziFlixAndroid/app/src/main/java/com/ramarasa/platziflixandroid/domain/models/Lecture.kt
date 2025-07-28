package com.ramarasa.platziflixandroid.domain.models

/**
 * Domain model representing a lecture in the application.
 * This is the core business entity that follows the CLEAR architecture principles.
 */
data class Lecture(
    val id: Int,
    val courseId: Int,
    val name: String,
    val description: String,
    val slug: String,
    val videoUrl: String,
    val createdAt: String,
    val updatedAt: String,
    val deletedAt: String?
) 