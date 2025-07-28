import Foundation
import Combine

// MARK: - CourseDetailViewModel
@MainActor
class CourseDetailViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var course: Course?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let courseRepository: CourseRepositoryProtocol
    private let courseSlug: String
    
    // MARK: - Computed Properties
    var hasError: Bool {
        errorMessage != nil
    }
    
    var lectures: [Lecture] {
        let lecturesList = course?.lectures ?? []
        print("🎓 CourseDetailViewModel: Returning \(lecturesList.count) lectures")
        return lecturesList
    }
    
    var teacherNames: String {
        guard let teacherIds = course?.teacherIds, !teacherIds.isEmpty else {
            return "Profesor no especificado"
        }
        
        // Por ahora simulamos nombres de profesores ya que no hay endpoint específico
        // En una implementación real, aquí haríamos una llamada al repositorio de profesores
        let names = teacherIds.map { "Profesor \($0)" }
        return names.joined(separator: ", ")
    }
    
    // MARK: - Initializer
    /// Initializes the ViewModel with a course slug and repository
    /// - Parameters:
    ///   - courseSlug: The slug of the course to fetch details for
    ///   - courseRepository: The repository to use for fetching course details
    init(
        courseSlug: String,
        courseRepository: CourseRepositoryProtocol = RemoteCourseRepository()
    ) {
        self.courseSlug = courseSlug
        self.courseRepository = courseRepository
        
        print("🎯 CourseDetailViewModel: Initializing with slug: \(courseSlug)")
        
        Task {
            await loadCourseDetails()
        }
    }
    
    // MARK: - Public Methods
    func loadCourseDetails() async {
        print("📚 CourseDetailViewModel: Starting to load course details for: \(courseSlug)")
        
        isLoading = true
        errorMessage = nil
        
        do {
            print("🔍 CourseDetailViewModel: Loading course details for slug: \(courseSlug)")
            let fetchedCourse = try await courseRepository.getCourse(by: courseSlug)
            print("✅ CourseDetailViewModel: Successfully loaded course: \(fetchedCourse.name)")
            print("🎓 CourseDetailViewModel: Course has \(fetchedCourse.lectures?.count ?? 0) lectures")
            
            course = fetchedCourse
            
            // Trigger UI update by accessing the computed property
            let _ = lectures
            
        } catch {
            print("❌ CourseDetailViewModel: Failed to load course details: \(error)")
            handleError(error)
        }
        
        isLoading = false
        print("🏁 CourseDetailViewModel: Finished loading course details. Final lecture count: \(lectures.count)")
    }
    
    func refreshCourseDetails() {
        print("🔄 CourseDetailViewModel: Refreshing course details")
        Task {
            await loadCourseDetails()
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func selectLecture(_ lecture: Lecture) {
        // TODO: Handle lecture selection navigation
        print("🎥 CourseDetailViewModel: Selected lecture: \(lecture.name)")
    }
}

// MARK: - Error Handling
extension CourseDetailViewModel {
    private func handleError(_ error: Error) {
        if let httpError = error as? HTTPError {
            errorMessage = httpError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
        print("❌ CourseDetailViewModel Error: \(error)")
    }
}

// MARK: - HTTPError LocalizedDescription Extension
extension HTTPError {
    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return "No hay conexión a internet. Verifica tu conexión y vuelve a intentar."
        case .timeout:
            return "La solicitud ha tardado demasiado. Vuelve a intentar."
        case .invalidURL:
            return "URL inválida."
        case .unauthorized:
            return "No autorizado. Verifica tus credenciales."
        case .forbidden:
            return "Acceso prohibido."
        case .notFound:
            return "Curso no encontrado."
        case .clientError(let statusCode, let message):
            return "Error del cliente (\(statusCode)): \(message)"
        case .serverError(let statusCode, let message):
            return "Error del servidor (\(statusCode)): \(message)"
        case .decodingError(let message):
            return "Error al procesar los datos: \(message)"
        case .networkError(let message):
            return "Error de red: \(message)"
        case .unknown(let message):
            return "Error desconocido: \(message)"
        case .noData:
            return "No se encontraron datos."
        case .encodingError(let message):
            return "Error al codificar los datos: \(message)"
        }
    }
} 