import SwiftUI

public enum ETAvatarSize {
    case small
    case medium
    case large
    case xLarge
    
    public var dimension: CGFloat {
        switch self {
        case .small: return 36
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 88
        }
    }
    
    public var font: Font {
        switch self {
        case .small: return .system(size: 13, weight: .bold)
        case .medium: return .system(size: 17, weight: .bold)
        case .large: return .system(size: 22, weight: .bold)
        case .xLarge: return .system(size: 30, weight: .bold)
        }
    }
    
    public var badgeSize: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 16
        case .large: return 20
        case .xLarge: return 24
        }
    }
}

public struct ETAvatar: View {
    private let name: String
    private let size: ETAvatarSize
    private let isVerified: Bool
    private let isAvailable: Bool
    private let showAvailability: Bool
    
    public init(
        name: String,
        size: ETAvatarSize = .medium,
        isVerified: Bool = false,
        isAvailable: Bool = false,
        showAvailability: Bool = false
    ) {
        self.name = name
        self.size = size
        self.isVerified = isVerified
        self.isAvailable = isAvailable
        self.showAvailability = showAvailability
    }
    
    private var initials: String {
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return "\(parts[0].prefix(1))\(parts[1].prefix(1))".uppercased()
        } else if let first = parts.first {
            return String(first.prefix(2)).uppercased()
        }
        return "ET"
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [ETColors.darkSurface, ETColors.pureBlack],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size.dimension, height: size.dimension)
                .overlay(
                    Circle()
                        .stroke(ETColors.primaryOrange.opacity(0.35), lineWidth: 1.5)
                )
                .overlay(
                    Text(initials)
                        .font(size.font)
                        .foregroundColor(ETColors.primaryOrange)
                )
            
            // Badge Vérifié ou Disponibilité
            if isVerified {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: size.badgeSize))
                    .foregroundColor(ETColors.primaryOrange)
                    .background(Circle().fill(ETColors.pureBlack).padding(1))
                    .offset(x: 2, y: 2)
            } else if showAvailability {
                Circle()
                    .fill(isAvailable ? ETColors.success : ETColors.secondaryText)
                    .frame(width: size.badgeSize, height: size.badgeSize)
                    .overlay(Circle().stroke(ETColors.pureBlack, lineWidth: 2))
                    .offset(x: 1, y: 1)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(name), \(isVerified ? "Profil vérifié" : "")")
    }
}
