package com.ramarasa.platziflixandroid.domain.models

/**
 * Domain model representing a course detail with its lectures.
 * This is the core business entity that follows the CLEAR architecture principles.
 */
data class CourseDetail(
    val id: Int,
    val name: String,
    val description: String,
    val thumbnail: String,
    val slug: String,
    val teacherIds: List<Int>,
    val lectures: List<Lecture>
) 