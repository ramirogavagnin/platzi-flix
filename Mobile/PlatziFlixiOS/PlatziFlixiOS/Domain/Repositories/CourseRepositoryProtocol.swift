import Foundation

/// Protocol that defines the contract for course repository operations
protocol CourseRepositoryProtocol {
    /// Fetches all available courses
    /// - Returns: An array of Course objects
    /// - Throws: HTTPError if the request fails
    func getCourses() async throws -> [Course]
    
    /// Fetches a specific course by its slug
    /// - Parameter slug: The unique slug identifier for the course
    /// - Returns: A Course object with detailed information including classes
    /// - Throws: HTTPError if the request fails or course is not found
    func getCourse(by slug: String) async throws -> Course
}