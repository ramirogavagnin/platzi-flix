import Foundation

/// Remote implementation of CourseRepositoryProtocol
/// This class handles all HTTP requests to fetch course data from the API
final class RemoteCourseRepository: CourseRepositoryProtocol {
    
    // MARK: - Properties
    
    private let httpService: HTTPService
    
    // MARK: - Initialization
    
    /// Initializes the repository with an HTTP service
    /// - Parameter httpService: The HTTP service to use for network requests
    init(httpService: HTTPService = URLSessionHTTPService()) {
        self.httpService = httpService
    }
    
    // MARK: - CourseRepositoryProtocol Implementation
    
    /// Fetches all available courses from the API
    /// - Returns: An array of Course domain models
    /// - Throws: HTTPError if the request fails
    func getCourses() async throws -> [Course] {
        // Build the endpoint for fetching all courses
        let endpoint = EndpointBuilder
            .get("/courses")
            .build()
        
        // Make the HTTP request and get DTOs
        let courseDTOs: [CourseDTO] = try await httpService.request(endpoint: endpoint)
        
        // Convert DTOs to domain models using the mapper
        let courses = CourseMapper.toDomain(from: courseDTOs)
        
        return courses
    }
    
    /// Fetches a specific course by its slug from the API
    /// - Parameter slug: The unique slug identifier for the course
    /// - Returns: A Course domain model with detailed information including lectures
    /// - Throws: HTTPError if the request fails or course is not found
    func getCourse(by slug: String) async throws -> Course {
        // Build the endpoint for fetching a specific course
        let endpoint = EndpointBuilder
            .get("/courses/\(slug)")
            .build()
        
        // Make the HTTP request and get DTO
        let courseDTO: CourseDTO = try await httpService.request(endpoint: endpoint)
        
        // Convert DTO to domain model using the mapper
        let course = CourseMapper.toDomain(from: courseDTO)
        
        return course
    }
}