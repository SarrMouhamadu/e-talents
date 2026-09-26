import SwiftUI

public enum ETBadgeStyle {
    case orange     // Fond orange discret + texte orange
    case neutral    // Fond sombre + texte blanc/gris
    case success    // Fond vert discret + texte vert (ex: Disponible)
    case outline    // Bordure sans fond
}

public struct ETBadge: View {
    private let text: String
    private let icon: String?
    private let style: ETBadgeStyle
    
    public init(
        _ text: String,
        icon: String? = nil,
        style: ETBadgeStyle = .orange
    ) {
        self.text = text
        self.icon = icon
        self.style = style
    }
    
    public var body: some View {
        HStack(spacing: ETSpacing.xxSmall) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 11, weight: .semibold))
            }
            Text(text)
                .font(ETTypography.badge)
        }
        .foregroundColor(foregroundColor)
        .padding(.horizontal, ETSpacing.small)
        .padding(.vertical, 5)
        .background(backgroundColor)
        .cornerRadius(ETRadius.small)
        .overlay(
            RoundedRectangle(cornerRadius: ETRadius.small)
                .stroke(borderColor, lineWidth: style == .outline ? 1 : 0)
        )
    }
    
    private var foregroundColor: Color {
        switch style {
        case .orange:
            return ETColors.primaryOrange
        case .neutral:
            return ETColors.pureWhite
        case .success:
            return ETColors.success
        case .outline:
            return ETColors.secondaryText
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .orange:
            return ETColors.primaryOrange.opacity(0.14)
        case .neutral:
            return ETColors.darkSurface
        case .success:
            return ETColors.success.opacity(0.14)
        case .outline:
            return Color.clear
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .outline:
            return ETColors.secondaryText.opacity(0.4)
        default:
            return Color.clear
        }
    }
}
