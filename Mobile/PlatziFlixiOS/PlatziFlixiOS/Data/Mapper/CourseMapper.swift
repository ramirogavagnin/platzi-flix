import Foundation

/// Mapper class responsible for converting between Data Transfer Objects (DTOs) and Domain Models
struct CourseMapper {
    
    // MARK: - Course Mapping
    
    /// Converts a CourseDTO to a Course domain model
    /// - Parameter dto: The CourseDTO from the API response
    /// - Returns: A Course domain model
    static func toDomain(from dto: CourseDTO) -> Course {
        return Course(
            id: dto.id,
            name: dto.name,
            description: dto.description,
            thumbnail: dto.thumbnail,
            slug: dto.slug,
            createdAt: dto.createdAt,
            updatedAt: dto.updatedAt,
            deletedAt: dto.deletedAt,
            teacherIds: dto.teacherIds,
            lectures: dto.classes?.map { toDomain(from: $0) }
        )
    }
    
    /// Converts an array of CourseDTOs to an array of Course domain models
    /// - Parameter dtos: Array of CourseDTOs from the API response
    /// - Returns: Array of Course domain models
    static func toDomain(from dtos: [CourseDTO]) -> [Course] {
        return dtos.map { toDomain(from: $0) }
    }
    
    /// Converts a Course domain model to a CourseDTO
    /// - Parameter course: The Course domain model
    /// - Returns: A CourseDTO for API requests
    static func toDTO(from course: Course) -> CourseDTO {
        return CourseDTO(
            id: course.id,
            name: course.name,
            description: course.description,
            thumbnail: course.thumbnail,
            slug: course.slug,
            createdAt: course.createdAt,
            updatedAt: course.updatedAt,
            deletedAt: course.deletedAt,
            teacherIds: course.teacherIds,
            classes: course.lectures?.map { toDTO(from: $0) }
        )
    }
    
    // MARK: - Lecture Mapping
    
    /// Converts a LectureDTO to a Lecture domain model
    /// - Parameter dto: The LectureDTO from the API response
    /// - Returns: A Lecture domain model
    static func toDomain(from dto: LectureDTO) -> Lecture {
        return Lecture(
            id: dto.id,
            courseId: dto.courseId,
            name: dto.name,
            description: dto.description,
            slug: dto.slug,
            videoUrl: dto.videoUrl,
            createdAt: dto.createdAt,
            updatedAt: dto.updatedAt,
            deletedAt: dto.deletedAt
        )
    }
    
    /// Converts a Lecture domain model to a LectureDTO
    /// - Parameter lecture: The Lecture domain model
    /// - Returns: A LectureDTO for API requests
    static func toDTO(from lecture: Lecture) -> LectureDTO {
        return LectureDTO(
            id: lecture.id,
            courseId: lecture.courseId,
            name: lecture.name,
            description: lecture.description,
            slug: lecture.slug,
            videoUrl: lecture.videoUrl,
            createdAt: lecture.createdAt,
            updatedAt: lecture.updatedAt,
            deletedAt: lecture.deletedAt
        )
    }
    
    // MARK: - Teacher Mapping
    
    /// Converts a TeacherDTO to a Teacher domain model
    /// - Parameter dto: The TeacherDTO from the API response
    /// - Returns: A Teacher domain model
    static func toDomain(from dto: TeacherDTO) -> Teacher {
        return Teacher(
            id: dto.id,
            name: dto.name,
            email: dto.email,
            createdAt: dto.createdAt,
            updatedAt: dto.updatedAt,
            deletedAt: dto.deletedAt
        )
    }
    
    /// Converts a Teacher domain model to a TeacherDTO
    /// - Parameter teacher: The Teacher domain model
    /// - Returns: A TeacherDTO for API requests
    static func toDTO(from teacher: Teacher) -> TeacherDTO {
        return TeacherDTO(
            id: teacher.id,
            name: teacher.name,
            email: teacher.email,
            createdAt: teacher.createdAt,
            updatedAt: teacher.updatedAt,
            deletedAt: teacher.deletedAt
        )
    }
}