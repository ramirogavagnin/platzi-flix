import SwiftUI

// MARK: - CourseListView
struct CourseListView: View {
    
    // MARK: - State
    @StateObject private var viewModel = CourseListViewModel()
    @State private var showingSearchBar = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                DesignSystem.Colors.groupedBackground.ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.courses.isEmpty {
                    loadingView
                } else if viewModel.hasError {
                    errorView
                } else {
                    courseListContent
                }
            }
            .navigationTitle("Últimos cursos lanzados")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSearchBar.toggle() }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                    }
                    .accessibilityLabel("Buscar cursos")
                }
            }
            .searchable(
                text: $viewModel.searchText,
                isPresented: $showingSearchBar,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Buscar cursos..."
            )
            .refreshable {
                await refreshCourses()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Course List Content
    private var courseListContent: some View {
        ScrollView {
            LazyVStack(spacing: DesignSystem.Spacing.listItemSpacing) {
                ForEach(viewModel.filteredCourses) { course in
                    CourseCardView(course: course) {
                        viewModel.selectCourse(course)
                    }
                    .padding(.horizontal, DesignSystem.Spacing.screenPadding)
                }
            }
            .padding(.vertical, DesignSystem.Spacing.listItemSpacing)
        }
        .overlay(
            Group {
                if viewModel.filteredCourses.isEmpty && !viewModel.searchText.isEmpty {
                    emptySearchView
                }
            }
        )
    }
    
    // MARK: - Loading View
    private var loadingView: some View {
        VStack(spacing: DesignSystem.Spacing.spacing4) {
            ProgressView()
                .scaleEffect(1.2)
            
            Text("Cargando cursos...")
                .font(DesignSystem.Typography.body)
                .foregroundColor(DesignSystem.Colors.secondaryText)
        }
        .accessibilityLabel("Cargando lista de cursos")
    }
    
    // MARK: - Error View
    private var errorView: some View {
        VStack(spacing: DesignSystem.Spacing.spacing4) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: DesignSystem.Size.iconXLarge))
                .foregroundColor(DesignSystem.Colors.warningOrange)
            
            Text("Error al cargar cursos")
                .font(DesignSystem.Typography.title3)
                .foregroundColor(DesignSystem.Colors.primaryText)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(DesignSystem.Typography.body)
                    .foregroundColor(DesignSystem.Colors.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, DesignSystem.Spacing.spacing8)
            }
            
            Button("Reintentar") {
                viewModel.refreshCourses()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .accessibilityLabel("Error al cargar cursos")
        .accessibilityHint("Toca reintentar para volver a cargar")
    }
    
    // MARK: - Empty Search View
    private var emptySearchView: some View {
        VStack(spacing: DesignSystem.Spacing.spacing4) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: DesignSystem.Size.iconXLarge))
                .foregroundColor(DesignSystem.Colors.secondaryText)
            
            Text("No se encontraron cursos")
                .font(DesignSystem.Typography.title3)
                .foregroundColor(DesignSystem.Colors.primaryText)
            
            Text("Intenta con otras palabras clave")
                .font(DesignSystem.Typography.body)
                .foregroundColor(DesignSystem.Colors.secondaryText)
        }
        .padding()
    }
    
    // MARK: - Methods
    @MainActor
    private func refreshCourses() async {
        viewModel.refreshCourses()
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}

// MARK: - Preview
#Preview("Course List") {
    CourseListView()
}

#Preview("Course List - Dark Mode") {
    CourseListView()
        .preferredColorScheme(.dark)
}

#Preview("Course List - Loading") {
    let viewModel = CourseListViewModel()
    CourseListView()
        .onAppear {
            viewModel.isLoading = true
        }
} 