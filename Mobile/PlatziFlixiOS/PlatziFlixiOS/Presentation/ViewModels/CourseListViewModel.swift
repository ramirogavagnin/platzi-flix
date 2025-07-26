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
    init() {
        loadCourses()
    }
    
    // MARK: - Public Methods
    func loadCourses() {
        isLoading = true
        errorMessage = nil
        
        // Simulate API call with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.courses = Course.sampleCourses
            self.isLoading = false
        }
    }
    
    func refreshCourses() {
        loadCourses()
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func selectCourse(_ course: Course) {
        // TODO: Handle course selection navigation
        print("Selected course: \(course.name)")
    }
}

// MARK: - Error Handling
extension CourseListViewModel {
    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        isLoading = false
    }
} 