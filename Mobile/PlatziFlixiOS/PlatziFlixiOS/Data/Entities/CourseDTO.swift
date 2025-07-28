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
    
    // MARK: - Normal Initializer
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
        classes: [LectureDTO]? = nil
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
        self.classes = classes
    }
    
    // MARK: - Custom Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        slug = try container.decode(String.self, forKey: .slug)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        deletedAt = try container.decodeIfPresent(String.self, forKey: .deletedAt)
        classes = try container.decodeIfPresent([LectureDTO].self, forKey: .classes)
        
        // Handle teacher_id as either Int or [Int]
        if let singleTeacherId = try? container.decodeIfPresent(Int.self, forKey: .teacherIds) {
            teacherIds = [singleTeacherId]
        } else if let multipleTeacherIds = try? container.decodeIfPresent([Int].self, forKey: .teacherIds) {
            teacherIds = multipleTeacherIds
        } else {
            teacherIds = nil
        }
    }
    
    // MARK: - Custom Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(slug, forKey: .slug)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(deletedAt, forKey: .deletedAt)
        try container.encodeIfPresent(classes, forKey: .classes)
        
        // Encode teacher_id as array if it has multiple values, or as single int if it has one
        if let teacherIds = teacherIds {
            if teacherIds.count == 1 {
                try container.encode(teacherIds.first, forKey: .teacherIds)
            } else {
                try container.encode(teacherIds, forKey: .teacherIds)
            }
        }
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