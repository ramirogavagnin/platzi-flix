import Foundation
import Combine

// MARK: - CourseListViewModel
@MainActor
class CourseListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var courses: [Course] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let courseRepository: CourseRepositoryProtocol
    
    // MARK: - Computed Properties
    var filteredCourses: [Course] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter { course in
                course.name.localizedCaseInsensitiveContains(searchText) ||
                course.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var hasError: Bool {
        errorMessage != nil
    }
    
    // MARK: - Initializer
    /// Initializes the ViewModel with a course repository
    /// - Parameter courseRepository: The repository to use for fetching courses. Defaults to RemoteCourseRepository
    init(courseRepository: CourseRepositoryProtocol = RemoteCourseRepository()) {
        self.courseRepository = courseRepository
        Task {
            await loadCourses()
        }
    }
    
    // MARK: - Public Methods
    func loadCourses() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedCourses = try await courseRepository.getCourses()
            courses = fetchedCourses
        } catch {
            handleError(error)
        }
        
        isLoading = false
    }
    
    func refreshCourses() {
        Task {
            await loadCourses()
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func selectCourse(_ course: Course) {
        // TODO: Handle course selection navigation
        print("Selected course: \(course.name)")
    }
    
    /// Fetches detailed information for a specific course
    /// - Parameter slug: The course slug
    /// - Returns: Course with detailed information including lectures
    func getCourseDetails(slug: String) async -> Course? {
        do {
            return try await courseRepository.getCourse(by: slug)
        } catch {
            handleError(error)
            return nil
        }
    }
}

// MARK: - Error Handling
extension CourseListViewModel {
    private func handleError(_ error: Error) {
        if let httpError = error as? HTTPError {
            errorMessage = httpError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
        print("❌ CourseListViewModel Error: \(error)")
    }
} 
