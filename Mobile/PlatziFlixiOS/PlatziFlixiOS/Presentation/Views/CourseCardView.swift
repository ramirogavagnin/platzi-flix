import SwiftUI

// MARK: - CourseCardView
struct CourseCardView: View {
    
    // MARK: - Properties
    let course: Course
    let onTap: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                // Course Thumbnail
                thumbnailView
                
                // Course Information
                courseInfoView
            }
            .cardStyle()
        }
        .buttonStyle(CardButtonStyle())
        .accessibilityLabel("Curso: \(course.name)")
        .accessibilityHint("Toca para ver los detalles del curso")
    }
    
    // MARK: - Thumbnail View
    private var thumbnailView: some View {
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
        .frame(height: DesignSystem.Size.cardImageHeight)
        .clipped()
    }
    
    // MARK: - Course Info View
    private var courseInfoView: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.smallSpacing) {
            // Course Title
            Text(course.name)
                .font(DesignSystem.Typography.cardTitle)
                .foregroundColor(DesignSystem.Colors.primaryText)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .padding(.bottom, DesignSystem.Spacing.titleBottomSpacing)
            
            // Course Description
            Text(course.description)
                .font(DesignSystem.Typography.cardDescription)
                .foregroundColor(DesignSystem.Colors.secondaryText)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(DesignSystem.Spacing.cardPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview
#Preview("Course Card") {
    CourseCardView(
        course: Course.sampleCourses[0],
        onTap: { print("Card tapped") }
    )
    .padding()
    .previewLayout(.sizeThatFits)
}

#Preview("Course Card - Dark Mode") {
    CourseCardView(
        course: Course.sampleCourses[0],
        onTap: { print("Card tapped") }
    )
    .padding()
    .previewLayout(.sizeThatFits)
    .preferredColorScheme(.dark)
} 