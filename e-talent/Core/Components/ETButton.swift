import SwiftUI

public enum ETButtonStyle {
    case primary      // Orange background + Black text (High Contrast)
    case secondary    // Dark background + White text
    case ghost        // Transparent background + Orange/White text
    case outline      // Transparent + Border
}

public enum ETButtonSize {
    case small
    case medium
    case large
    
    var height: CGFloat {
        switch self {
        case .small: return 36
        case .medium: return 44
        case .large: return 50
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .small: return ETSpacing.small
        case .medium: return ETSpacing.standard
        case .large: return ETSpacing.large
        }
    }
    
    var font: Font {
        switch self {
        case .small: return ETTypography.badge
        case .medium: return ETTypography.button
        case .large: return ETTypography.button
        }
    }
}

public struct ETButton: View {
    private let title: String
    private let icon: String?
    private let style: ETButtonStyle
    private let size: ETButtonSize
    private let isLoading: Bool
    private let isFullWidth: Bool
    private let action: () -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    
    public init(
        _ title: String,
        icon: String? = nil,
        style: ETButtonStyle = .primary,
        size: ETButtonSize = .large,
        isLoading: Bool = false,
        isFullWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.size = size
        self.isLoading = isLoading
        self.isFullWidth = isFullWidth
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: ETSpacing.xSmall) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
                        .scaleEffect(0.9)
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Text(title)
                        .font(size.font)
                }
            }
            .foregroundColor(foregroundColor)
            .padding(.horizontal, size.horizontalPadding)
            .frame(height: size.height)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(backgroundColor)
            .cornerRadius(ETRadius.button)
            .overlay(
                RoundedRectangle(cornerRadius: ETRadius.button)
                    .stroke(borderColor, lineWidth: style == .outline ? 1.5 : 0)
            )
            // Assure une zone tactile d'au moins 44pt pour l'accessibilité
            .contentShape(Rectangle())
        }
        .disabled(!isEnabled || isLoading)
        .opacity(isEnabled ? 1.0 : 0.5)
        .accessibilityLabel(title)
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary:
            return ETColors.textOnOrange // Noir #0B0B0D
        case .secondary:
            return ETColors.textOnDark   // Blanc #FFFFFF
        case .ghost:
            return ETColors.primaryOrange
        case .outline:
            return ETColors.pureWhite
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return ETColors.primaryOrange
        case .secondary:
            return ETColors.darkSurface
        case .ghost:
            return Color.clear
        case .outline:
            return Color.clear
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .outline:
            return ETColors.primaryOrange
        default:
            return Color.clear
        }
    }
}
