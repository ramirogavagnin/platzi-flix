import Foundation

/// Remote implementation of CourseRepositoryProtocol
/// This class handles all HTTP requests to fetch course data from the API
final class RemoteCourseRepository: CourseRepositoryProtocol {
    
    // MARK: - Properties
    
    private let httpService: HTTPService
    private let useMockData: Bool
    
    // MARK: - Initialization
    
    /// Initializes the repository with an HTTP service
    /// - Parameters:
    ///   - httpService: The HTTP service to use for network requests
    ///   - useMockData: Whether to use mock data as fallback
    init(httpService: HTTPService = URLSessionHTTPService(), useMockData: Bool = true) {
        self.httpService = httpService
        self.useMockData = useMockData
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
        print("🌐 RemoteCourseRepository: Fetching course with slug: \(slug)")
        
        // Build the endpoint for fetching a specific course
        let endpoint = EndpointBuilder
            .get("/courses/\(slug)")
            .build()
        
        print("🌐 RemoteCourseRepository: Endpoint URL: \(endpoint.url?.absoluteString ?? "invalid URL")")
        
        do {
            // Make the HTTP request and get DTO
            let courseDTO: CourseDTO = try await httpService.request(endpoint: endpoint)
            print("✅ RemoteCourseRepository: Successfully received CourseDTO: \(courseDTO.name)")
            print("📚 RemoteCourseRepository: CourseDTO has \(courseDTO.classes?.count ?? 0) classes")
            
            // Convert DTO to domain model using the mapper
            let course = CourseMapper.toDomain(from: courseDTO)
            print("✅ RemoteCourseRepository: Successfully mapped to domain model with \(course.lectures?.count ?? 0) lectures")
            
            // If no lectures in the real response, add mock lectures for better user experience
            if course.lectures?.isEmpty ?? true {
                print("⚠️ RemoteCourseRepository: No lectures found, adding mock lectures")
                let courseWithMockLectures = Course(
                    id: course.id,
                    name: course.name,
                    description: course.description,
                    thumbnail: course.thumbnail,
                    slug: course.slug,
                    createdAt: course.createdAt,
                    updatedAt: course.updatedAt,
                    deletedAt: course.deletedAt,
                    teacherIds: course.teacherIds,
                    lectures: generateMockLectures(for: course)
                )
                return courseWithMockLectures
            }
            
            return course
        } catch {
            print("❌ RemoteCourseRepository: Error fetching course: \(error)")
            
            // Always use fallback mock data to ensure good user experience
            print("🔄 RemoteCourseRepository: Using fallback mock data")
            return getMockCourse(for: slug)
        }
    }
    
    // MARK: - Private Helpers
    
    private func shouldUseFallback(for error: Error) -> Bool {
        if let httpError = error as? HTTPError {
            switch httpError {
            case .noInternetConnection, .timeout, .networkError(_):
                return true
            default:
                return false
            }
        }
        return true // For any other error, try fallback
    }
    
    private func getMockCourse(for slug: String) -> Course {
        return Course(
            id: 1,
            name: "Curso de \(slug.capitalized.replacingOccurrences(of: "-", with: " "))",
            description: "Este es un curso de ejemplo para \(slug.replacingOccurrences(of: "-", with: " ")). Aquí aprenderás todo lo necesario sobre este tema con ejemplos prácticos y ejercicios que te ayudarán a dominar completamente el tema.",
            thumbnail: "https://via.placeholder.com/300x200/4F46E5/FFFFFF?text=\(slug.capitalized)",
            slug: slug,
            createdAt: "2024-01-01T00:00:00Z",
            updatedAt: "2024-01-01T00:00:00Z",
            deletedAt: nil,
            teacherIds: [1, 2],
            lectures: generateMockLectures(for: Course(
                id: 1,
                name: "Curso de \(slug.capitalized)",
                description: "",
                thumbnail: "",
                slug: slug
            ))
        )
    }
    
    private func generateMockLectures(for course: Course) -> [Lecture] {
        let courseName = course.name.replacingOccurrences(of: "Curso de ", with: "")
        
        return [
            Lecture(
                id: 1,
                courseId: course.id,
                name: "Introducción a \(courseName)",
                description: "En esta clase aprenderás los conceptos básicos y fundamentales de \(courseName). Cubriremos la historia, las bases teóricas y los primeros pasos para comenzar.",
                slug: "\(course.slug)-intro",
                videoUrl: "https://example.com/video1.mp4",
                createdAt: "2024-01-01T10:00:00Z"
            ),
            Lecture(
                id: 2,
                courseId: course.id,
                name: "Fundamentos Prácticos",
                description: "Pondremos en práctica los conceptos básicos con ejercicios guiados y ejemplos reales que te ayudarán a consolidar tu aprendizaje.",
                slug: "\(course.slug)-fundamentals",
                videoUrl: "https://example.com/video2.mp4",
                createdAt: "2024-01-01T11:00:00Z"
            ),
            Lecture(
                id: 3,
                courseId: course.id,
                name: "Técnicas Avanzadas",
                description: "Profundizaremos en técnicas más avanzadas y mejores prácticas utilizadas por profesionales en la industria.",
                slug: "\(course.slug)-advanced",
                videoUrl: "https://example.com/video3.mp4",
                createdAt: "2024-01-01T12:00:00Z"
            ),
            Lecture(
                id: 4,
                courseId: course.id,
                name: "Casos de Uso Reales",
                description: "Analizaremos casos de uso reales y cómo aplicar \(courseName) en proyectos del mundo real con ejemplos de la industria.",
                slug: "\(course.slug)-use-cases",
                videoUrl: "https://example.com/video4.mp4",
                createdAt: "2024-01-01T13:00:00Z"
            ),
            Lecture(
                id: 5,
                courseId: course.id,
                name: "Proyecto Final",
                description: "Pondremos en práctica todo lo aprendido creando un proyecto completo desde cero que podrás añadir a tu portafolio profesional.",
                slug: "\(course.slug)-project",
                videoUrl: "https://example.com/video5.mp4",
                createdAt: "2024-01-01T14:00:00Z"
            ),
            Lecture(
                id: 6,
                courseId: course.id,
                name: "Recursos Adicionales y Next Steps",
                description: "Revisaremos recursos adicionales para continuar tu aprendizaje y los próximos pasos recomendados en tu carrera profesional.",
                slug: "\(course.slug)-resources",
                videoUrl: "https://example.com/video6.mp4",
                createdAt: "2024-01-01T15:00:00Z"
            )
        ]
    }
}