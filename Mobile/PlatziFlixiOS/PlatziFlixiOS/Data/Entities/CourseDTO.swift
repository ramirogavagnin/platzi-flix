import Foundation

// MARK: - Course DTO (Data Transfer Object)
/// Represents the raw course data structure from the API response
struct CourseDTO: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: String
    let slug: String
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    let teacherIds: [Int]?
    let classes: [LectureDTO]? // Only present in detailed course response
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
        case slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case teacherIds = "teacher_id"
        case classes
    }
}

// MARK: - Lecture DTO
/// Represents the raw lecture data structure from the API response
struct LectureDTO: Codable {
    let id: Int
    let courseId: Int?
    let name: String
    let description: String
    let slug: String
    let videoUrl: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case courseId = "course_id"
        case name
        case description
        case slug
        case videoUrl = "video_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Teacher DTO
/// Represents the raw teacher data structure from the API response
struct TeacherDTO: Codable {
    let id: Int
    let name: String
    let email: String
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}