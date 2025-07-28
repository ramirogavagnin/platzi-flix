package com.ramarasa.platziflixandroid.navigation

/**
 * Navigation routes for the application.
 * Defines all possible navigation destinations.
 */
object NavRoutes {
    const val COURSE_LIST = "course_list"
    const val COURSE_DETAIL = "course_detail/{slug}"
    
    /**
     * Creates the course detail route with the given slug.
     * 
     * @param slug The course slug
     * @return The formatted route string
     */
    fun courseDetail(slug: String): String {
        return "course_detail/$slug"
    }
} 