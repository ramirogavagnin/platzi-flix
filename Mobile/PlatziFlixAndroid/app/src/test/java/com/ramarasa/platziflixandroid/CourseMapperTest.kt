package com.ramarasa.platziflixandroid

import com.ramarasa.platziflixandroid.data.entities.CourseDTO
import com.ramarasa.platziflixandroid.data.mappers.CourseMapper
import com.ramarasa.platziflixandroid.domain.models.Course
import org.junit.Assert.*
import org.junit.Test

class CourseMapperTest {
    
    @Test
    fun `toDomain should handle null values correctly`() {
        // Arrange
        val inputDto = CourseDTO(
            id = 1,
            name = null,
            description = null,
            thumbnail = null,
            slug = null,
            createdAt = null,
            updatedAt = null,
            deletedAt = null,
            teacherIds = null
        )
        
        // Act
        val actualCourse = CourseMapper.toDomain(inputDto)
        
        // Assert
        assertEquals(1, actualCourse.id)
        assertEquals("Sin nombre", actualCourse.name)
        assertEquals("Sin descripción", actualCourse.description)
        assertEquals("", actualCourse.thumbnail)
        assertEquals("", actualCourse.slug)
        assertNotNull(actualCourse.createdAt)
        assertNotNull(actualCourse.updatedAt)
        assertNull(actualCourse.deletedAt)
        assertTrue(actualCourse.teacherIds.isEmpty())
    }
    
    @Test
    fun `toDomain should preserve non-null values`() {
        // Arrange
        val inputDto = CourseDTO(
            id = 2,
            name = "Kotlin Avanzado",
            description = "Curso de Kotlin para desarrolladores experimentados",
            thumbnail = "https://example.com/thumbnail.jpg",
            slug = "kotlin-avanzado",
            createdAt = "2024-01-01T00:00:00.000Z",
            updatedAt = "2024-01-02T00:00:00.000Z",
            deletedAt = null,
            teacherIds = listOf(1, 2, 3)
        )
        
        // Act
        val actualCourse = CourseMapper.toDomain(inputDto)
        
        // Assert
        assertEquals(2, actualCourse.id)
        assertEquals("Kotlin Avanzado", actualCourse.name)
        assertEquals("Curso de Kotlin para desarrolladores experimentados", actualCourse.description)
        assertEquals("https://example.com/thumbnail.jpg", actualCourse.thumbnail)
        assertEquals("kotlin-avanzado", actualCourse.slug)
        assertEquals("2024-01-01T00:00:00.000Z", actualCourse.createdAt)
        assertEquals("2024-01-02T00:00:00.000Z", actualCourse.updatedAt)
        assertNull(actualCourse.deletedAt)
        assertEquals(listOf(1, 2, 3), actualCourse.teacherIds)
    }
    
    @Test
    fun `toDomainList should handle empty list`() {
        // Arrange
        val inputDtos = emptyList<CourseDTO>()
        
        // Act
        val actualCourses = CourseMapper.toDomainList(inputDtos)
        
        // Assert
        assertTrue(actualCourses.isEmpty())
    }
    
    @Test
    fun `toDomainList should handle list with mixed null and non-null values`() {
        // Arrange
        val inputDtos = listOf(
            CourseDTO(
                id = 1,
                name = null,
                description = "Descripción válida",
                thumbnail = null,
                slug = "slug-valido",
                createdAt = null,
                updatedAt = "2024-01-01T00:00:00.000Z",
                deletedAt = null,
                teacherIds = null
            ),
            CourseDTO(
                id = 2,
                name = "Nombre válido",
                description = null,
                thumbnail = "https://example.com/thumb.jpg",
                slug = null,
                createdAt = "2024-01-02T00:00:00.000Z",
                updatedAt = null,
                deletedAt = null,
                teacherIds = listOf(1)
            )
        )
        
        // Act
        val actualCourses = CourseMapper.toDomainList(inputDtos)
        
        // Assert
        assertEquals(2, actualCourses.size)
        
        // First course
        assertEquals("Sin nombre", actualCourses[0].name)
        assertEquals("Descripción válida", actualCourses[0].description)
        assertEquals("", actualCourses[0].thumbnail)
        assertEquals("slug-valido", actualCourses[0].slug)
        assertNotNull(actualCourses[0].createdAt)
        assertEquals("2024-01-01T00:00:00.000Z", actualCourses[0].updatedAt)
        assertTrue(actualCourses[0].teacherIds.isEmpty())
        
        // Second course
        assertEquals("Nombre válido", actualCourses[1].name)
        assertEquals("Sin descripción", actualCourses[1].description)
        assertEquals("https://example.com/thumb.jpg", actualCourses[1].thumbnail)
        assertEquals("", actualCourses[1].slug)
        assertEquals("2024-01-02T00:00:00.000Z", actualCourses[1].createdAt)
        assertNotNull(actualCourses[1].updatedAt)
        assertEquals(listOf(1), actualCourses[1].teacherIds)
    }
} 