import SwiftUI

// MARK: - CourseDetailView
struct CourseDetailView: View {
    
    // MARK: - Properties
    let courseSlug: String
    @StateObject private var viewModel: CourseDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Initializer
    init(courseSlug: String) {
        self.courseSlug = courseSlug
        self._viewModel = StateObject(wrappedValue: CourseDetailViewModel(courseSlug: courseSlug))
        print("🔧 CourseDetailView: Initializing with slug: \(courseSlug)")
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                DesignSystem.Colors.groupedBackground.ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.course == nil {
                    loadingView
                } else if viewModel.hasError {
                    errorView
                } else if let course = viewModel.course {
                    courseDetailContent(course: course)
                } else {
                    // Fallback content
                    Text("No se pudo cargar el curso")
                        .font(DesignSystem.Typography.body)
                        .foregroundColor(DesignSystem.Colors.secondaryText)
                }
            }
            .navigationTitle("Detalle del Curso")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
            .refreshable {
                await refreshCourse()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            print("👀 CourseDetailView: View appeared for slug: \(courseSlug)")
            print("📊 CourseDetailView: Current lecture count: \(viewModel.lectures.count)")
        }
    }
    
    // MARK: - Course Detail Content
    private func courseDetailContent(course: Course) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.spacing4) {
                // Course Header
                courseHeaderView(course: course)       
                
                // Lectures Section
                lecturesContentView
            }
            .padding(DesignSystem.Spacing.screenPadding)
        }
    }
    
    // MARK: - Lectures Content View
    private var lecturesContentView: some View {
        Group {
            let currentLectures = viewModel.lectures
            
            if !currentLectures.isEmpty {
                lecturesSection(lectures: currentLectures)
                    .onAppear {
                        print("🎬 CourseDetailView: Rendering lectures section with \(currentLectures.count) lectures")
                    }
            } else {
                emptyLecturesView
                    .onAppear {
                        print("⚠️ CourseDetailView: No lectures available, showing empty state")
                    }
            }
        }
    }
    
    // MARK: - Course Header View
    private func courseHeaderView(course: Course) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.spacing3) {
            // Course Thumbnail
            AsyncImage(url: URL(string: course.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(DesignSystem.Colors.placeholderGray)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: DesignSystem.Size.iconXLarge))
                            .foregroundColor(.secondary)
                    )
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium))
            
            // Course Title
            Text(course.name)
                .font(DesignSystem.Typography.title1)
                .foregroundColor(DesignSystem.Colors.primaryText)
                .multilineTextAlignment(.leading)
            
            // Teacher Name
            HStack {
                Image(systemName: "person.circle")
                    .font(.system(size: DesignSystem.Size.iconMedium))
                    .foregroundColor(DesignSystem.Colors.accentBlue)
                
                Text(viewModel.teacherNames)
                    .font(DesignSystem.Typography.headline)
                    .foregroundColor(DesignSystem.Colors.secondaryText)
            }
            
            // Course Description
            Text(course.description)
                .font(DesignSystem.Typography.body)
                .foregroundColor(DesignSystem.Colors.primaryText)
                .multilineTextAlignment(.leading)
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium))
    }
    
    // MARK: - Lectures Section
    private func lecturesSection(lectures: [Lecture]) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.spacing2) {
            // Section Header
            HStack {
                Image(systemName: "play.rectangle")
                    .font(.system(size: DesignSystem.Size.iconMedium))
                    .foregroundColor(DesignSystem.Colors.accentBlue)
                
                Text("Clases (\(lectures.count))")
                    .font(DesignSystem.Typography.headline)
                    .foregroundColor(DesignSystem.Colors.primaryText)
                
                Spacer()
            }
            .padding(.horizontal, DesignSystem.Spacing.cardPadding)
            
            // Lectures List
            LazyVStack(spacing: DesignSystem.Spacing.listItemSpacing) {
                ForEach(Array(lectures.enumerated()), id: \.element.id) { index, lecture in
                    LectureRowView(
                        lecture: lecture,
                        index: index + 1,
                        onTap: {
                            print("🎥 CourseDetailView: Lecture tapped: \(lecture.name)")
                            viewModel.selectLecture(lecture)
                        }
                    )
                }
            }
        }
    }
    
    // MARK: - Empty Lectures View
    private var emptyLecturesView: some View {
        VStack(spacing: DesignSystem.Spacing.spacing2) {
            Image(systemName: "video.slash")
                .font(.system(size: DesignSystem.Size.iconXLarge))
                .foregroundColor(DesignSystem.Colors.secondaryText)
            
            Text("Sin clases disponibles")
                .font(DesignSystem.Typography.headline)
                .foregroundColor(DesignSystem.Colors.primaryText)
            
            Text("Este curso aún no tiene clases publicadas")
                .font(DesignSystem.Typography.body)
                .foregroundColor(DesignSystem.Colors.secondaryText)
                .multilineTextAlignment(.center)
        }
        .padding(DesignSystem.Spacing.spacing6)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium))
    }
    
    // MARK: - Loading View
    private var loadingView: some View {
        VStack(spacing: DesignSystem.Spacing.spacing4) {
            ProgressView()
                .scaleEffect(1.2)
            
            Text("Cargando detalles del curso...")
                .font(DesignSystem.Typography.body)
                .foregroundColor(DesignSystem.Colors.secondaryText)
        }
        .accessibilityLabel("Cargando detalles del curso")
    }
    
    // MARK: - Error View
    private var errorView: some View {
        VStack(spacing: DesignSystem.Spacing.spacing4) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: DesignSystem.Size.iconXLarge))
                .foregroundColor(DesignSystem.Colors.warningOrange)
            
            Text("Error al cargar curso")
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
                print("🔄 CourseDetailView: Retry button tapped")
                viewModel.refreshCourseDetails()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .accessibilityLabel("Error al cargar curso")
        .accessibilityHint("Toca reintentar para volver a cargar")
    }
    
    // MARK: - Methods
    @MainActor
    private func refreshCourse() async {
        print("🔄 CourseDetailView: Pull to refresh triggered")
        viewModel.refreshCourseDetails()
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}

// MARK: - LectureRowView
struct LectureRowView: View {
    let lecture: Lecture
    let index: Int
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: DesignSystem.Spacing.spacing3) {
                // Lecture Number
                Circle()
                    .fill(DesignSystem.Colors.accentBlue)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text("\(index)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    )
                
                // Lecture Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(lecture.name)
                        .font(DesignSystem.Typography.headline)
                        .foregroundColor(DesignSystem.Colors.primaryText)
                        .multilineTextAlignment(.leading)
                    
                    Text(lecture.description)
                        .font(DesignSystem.Typography.caption)
                        .foregroundColor(DesignSystem.Colors.secondaryText)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                // Play Icon
                Image(systemName: "play.circle")
                    .font(.system(size: DesignSystem.Size.iconMedium))
                    .foregroundColor(DesignSystem.Colors.accentBlue)
            }
            .padding(DesignSystem.Spacing.cardPadding)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium))
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Clase \(index): \(lecture.name)")
        .accessibilityHint("Toca para reproducir la clase")
    }
}

// MARK: - Preview
#Preview("Course Detail") {
    CourseDetailView(courseSlug: "curso-de-react")
}

#Preview("Course Detail - Dark Mode") {
    CourseDetailView(courseSlug: "curso-de-react")
        .preferredColorScheme(.dark)
} 