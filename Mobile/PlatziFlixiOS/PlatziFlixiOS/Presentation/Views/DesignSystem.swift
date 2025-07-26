import SwiftUI

// MARK: - Design System
struct DesignSystem {
    
    // MARK: - Colors
    struct Colors {
        
        // MARK: - Primary Colors
        static let primaryBlue = Color(hex: "#007AFF")
        static let primaryGreen = Color(hex: "#34C759")
        static let primaryRed = Color(hex: "#FF3B30")
        
        // MARK: - Neutral Colors
        static let neutralBlack = Color(hex: "#000000")
        static let neutralGray900 = Color(hex: "#1C1C1E")
        static let neutralGray800 = Color(hex: "#2C2C2E")
        static let neutralGray600 = Color(hex: "#8E8E93")
        static let neutralGray400 = Color(hex: "#C7C7CC")
        static let neutralGray200 = Color(hex: "#F2F2F7")
        static let neutralWhite = Color(hex: "#FFFFFF")
        
        // MARK: - Semantic Colors
        static let successGreen = Color(hex: "#30D158")
        static let warningOrange = Color(hex: "#FF9500")
        static let errorRed = Color(hex: "#FF453A")
        static let infoBlue = Color(hex: "#64D2FF")
        
        // MARK: - System Adaptive Colors
        static let background = Color(.systemBackground)
        static let secondaryBackground = Color(.secondarySystemBackground)
        static let groupedBackground = Color(.systemGroupedBackground)
        static let primaryText = Color(.label)
        static let secondaryText = Color(.secondaryLabel)
        static let tertiaryText = Color(.tertiaryLabel)
        static let placeholderText = Color(.placeholderText)
        static let separator = Color(.separator)
        
        // MARK: - Component Specific Colors
        static let cardBackground = Color(.systemBackground)
        static let cardShadow = Color.black.opacity(0.1)
        static let placeholderGray = Color(.systemGray4)
        static let navBarBackground = Color(.systemBackground)
    }
    
    // MARK: - Typography
    struct Typography {
        
        // MARK: - Headings
        static let largeTitle = Font.largeTitle.weight(.bold)
        static let title1 = Font.title.weight(.semibold)
        static let title2 = Font.title2.weight(.semibold)
        static let title3 = Font.title3.weight(.medium)
        
        // MARK: - Body Text
        static let body = Font.body.weight(.regular)
        static let bodyEmphasized = Font.body.weight(.medium)
        static let caption = Font.caption.weight(.regular)
        static let caption2 = Font.caption2.weight(.regular)
        
        // MARK: - Interactive
        static let buttonLarge = Font.headline.weight(.semibold)
        static let buttonMedium = Font.body.weight(.medium)
        static let buttonSmall = Font.caption.weight(.medium)
        
        // MARK: - Card Typography
        static let cardTitle = Font.headline.weight(.semibold)
        static let cardDescription = Font.body.weight(.regular)
    }
    
    // MARK: - Spacing
    struct Spacing {
        
        // MARK: - Base Spacing (8pt system)
        static let spacing1: CGFloat = 4.0   // 0.5x
        static let spacing2: CGFloat = 8.0   // 1x
        static let spacing3: CGFloat = 12.0  // 1.5x
        static let spacing4: CGFloat = 16.0  // 2x
        static let spacing5: CGFloat = 20.0  // 2.5x
        static let spacing6: CGFloat = 24.0  // 3x
        static let spacing8: CGFloat = 32.0  // 4x
        static let spacing10: CGFloat = 40.0 // 5x
        static let spacing12: CGFloat = 48.0 // 6x
        static let spacing16: CGFloat = 64.0 // 8x
        
        // MARK: - Common Use Cases
        static let cardPadding: CGFloat = spacing4 // 16pt
        static let listItemSpacing: CGFloat = spacing3 // 12pt
        static let sectionSpacing: CGFloat = spacing6 // 24pt
        static let screenPadding: CGFloat = spacing4 // 16pt
        static let smallSpacing: CGFloat = spacing2 // 8pt
        static let titleBottomSpacing: CGFloat = spacing1 // 4pt
    }
    
    // MARK: - Border Radius
    struct Radius {
        static let small: CGFloat = 4.0
        static let medium: CGFloat = 8.0
        static let large: CGFloat = 12.0
        static let xLarge: CGFloat = 16.0
        static let xxLarge: CGFloat = 24.0
        static let full: CGFloat = 1000.0
        
        // MARK: - Component Specific
        static let card: CGFloat = large // 12pt
        static let button: CGFloat = medium // 8pt
        static let textField: CGFloat = medium // 8pt
    }
    
    // MARK: - Shadows
    struct Shadow {
        static let cardShadowRadius: CGFloat = 8.0
        static let cardShadowX: CGFloat = 0
        static let cardShadowY: CGFloat = 4
        static let buttonShadowRadius: CGFloat = 4.0
        static let floatingShadowRadius: CGFloat = 16.0
    }
    
    // MARK: - Sizes
    struct Size {
        
        // MARK: - Touch Targets
        static let minimumTouchTarget: CGFloat = 44.0
        
        // MARK: - Component Sizes
        static let cardImageHeight: CGFloat = 200.0
        static let buttonHeight: CGFloat = 48.0
        static let textFieldHeight: CGFloat = 44.0
        static let iconSmall: CGFloat = 16.0
        static let iconMedium: CGFloat = 24.0
        static let iconLarge: CGFloat = 32.0
        static let iconXLarge: CGFloat = 48.0
    }
    
    // MARK: - Animation
    struct Animation {
        static let quickSpring = SwiftUI.Animation.easeInOut(duration: 0.1)
        static let mediumSpring = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let slowSpring = SwiftUI.Animation.easeInOut(duration: 0.5)
        
        // MARK: - Button Animations
        static let buttonPress = SwiftUI.Animation.easeInOut(duration: 0.1)
        static let cardHover = SwiftUI.Animation.easeInOut(duration: 0.2)
    }
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Custom Button Styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.buttonLarge)
            .foregroundColor(DesignSystem.Colors.neutralWhite)
            .frame(maxWidth: .infinity)
            .frame(height: DesignSystem.Size.buttonHeight)
            .background(DesignSystem.Colors.primaryBlue)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.button))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(DesignSystem.Animation.buttonPress, value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.buttonMedium)
            .foregroundColor(DesignSystem.Colors.primaryText)
            .frame(maxWidth: .infinity)
            .frame(height: DesignSystem.Size.buttonHeight)
            .background(DesignSystem.Colors.secondaryBackground)
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.button)
                    .stroke(DesignSystem.Colors.separator, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.button))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(DesignSystem.Animation.buttonPress, value: configuration.isPressed)
    }
}

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(DesignSystem.Animation.cardHover, value: configuration.isPressed)
    }
}

// MARK: - Custom View Modifiers
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(DesignSystem.Colors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.card))
            .shadow(
                color: DesignSystem.Colors.cardShadow,
                radius: DesignSystem.Shadow.cardShadowRadius,
                x: DesignSystem.Shadow.cardShadowX,
                y: DesignSystem.Shadow.cardShadowY
            )
    }
}

// MARK: - View Extension for Easy Access
extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}

// MARK: - Design System Preview
#Preview("Design System Colors") {
    ScrollView {
        VStack(spacing: DesignSystem.Spacing.spacing4) {
            
            // Primary Colors
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.spacing2) {
                Text("Primary Colors")
                    .font(DesignSystem.Typography.title3)
                
                HStack(spacing: DesignSystem.Spacing.spacing2) {
                    ColorSwatch(color: DesignSystem.Colors.primaryBlue, name: "Blue")
                    ColorSwatch(color: DesignSystem.Colors.primaryGreen, name: "Green")
                    ColorSwatch(color: DesignSystem.Colors.primaryRed, name: "Red")
                }
            }
            
            // Buttons
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.spacing2) {
                Text("Button Styles")
                    .font(DesignSystem.Typography.title3)
                
                Button("Primary Button") {}
                    .buttonStyle(PrimaryButtonStyle())
                
                Button("Secondary Button") {}
                    .buttonStyle(SecondaryButtonStyle())
            }
        }
        .padding(DesignSystem.Spacing.screenPadding)
    }
}

// MARK: - Helper Views for Preview
private struct ColorSwatch: View {
    let color: Color
    let name: String
    
    var body: some View {
        VStack(spacing: DesignSystem.Spacing.spacing1) {
            Rectangle()
                .fill(color)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.medium))
            
            Text(name)
                .font(DesignSystem.Typography.caption)
                .foregroundColor(DesignSystem.Colors.secondaryText)
        }
    }
} 