import Foundation

// MARK: - Course Model
struct Course: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: String
    let slug: String
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    let teacherIds: [Int]?
    let lectures: [Lecture]? // Classes/Lectures associated with the course
    
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
        case lectures = "classes"
    }
    
    // MARK: - Initializers
    init(
        id: Int,
        name: String,
        description: String,
        thumbnail: String,
        slug: String,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        deletedAt: String? = nil,
        teacherIds: [Int]? = nil,
        lectures: [Lecture]? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.slug = slug
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.teacherIds = teacherIds
        self.lectures = lectures
    }
}

// MARK: - Lecture Model
struct Lecture: Identifiable, Codable, Equatable {
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
    
    // MARK: - Initializers
    init(
        id: Int,
        courseId: Int? = nil,
        name: String,
        description: String,
        slug: String,
        videoUrl: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        deletedAt: String? = nil
    ) {
        self.id = id
        self.courseId = courseId
        self.name = name
        self.description = description
        self.slug = slug
        self.videoUrl = videoUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

// MARK: - Teacher Model
struct Teacher: Identifiable, Codable, Equatable {
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
    
    // MARK: - Initializers
    init(
        id: Int,
        name: String,
        email: String,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        deletedAt: String? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

// MARK: - Sample Data
extension Course {
    static let sampleCourses: [Course] = [
        Course(
            id: 1,
            name: "Curso de Cursor",
            description: "Cursor es un entorno de desarrollo integrado impulsado por IA para Windows, macOS ...",
            thumbnail: "https://via.placeholder.com/300x200",
            slug: "curso-de-cursor"
        ),
        Course(
            id: 2,
            name: "Curso de React",
            description: "Aprende React desde cero hasta nivel avanzado con los mejores profesores",
            thumbnail: "https://via.placeholder.com/300x200",
            slug: "curso-de-react"
        ),
        Course(
            id: 3,
            name: "Curso de Swift",
            description: "Domina el desarrollo iOS con Swift y SwiftUI de forma práctica",
            thumbnail: "https://via.placeholder.com/300x200",
            slug: "curso-de-swift"
        ),
        Course(
            id: 4,
            name: "Curso de Node.js",
            description: "Backend development con Node.js y Express para aplicaciones modernas",
            thumbnail: "https://via.placeholder.com/300x200",
            slug: "curso-de-nodejs"
        )
    ]
} 