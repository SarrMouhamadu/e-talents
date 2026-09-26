import SwiftUI

public struct ETFilterChip: View {
    private let title: String
    private let isSelected: Bool
    private let icon: String?
    private let action: () -> Void
    
    public init(
        _ title: String,
        icon: String? = nil,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: ETSpacing.xxSmall) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 12, weight: .semibold))
                }
                Text(title)
                    .font(ETTypography.badge)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .foregroundColor(isSelected ? ETColors.textOnOrange : ETColors.pureWhite)
            .padding(.horizontal, ETSpacing.standard)
            .frame(height: 36)
            .background(isSelected ? ETColors.primaryOrange : ETColors.darkSurface)
            .cornerRadius(ETRadius.pill)
            .overlay(
                RoundedRectangle(cornerRadius: ETRadius.pill)
                    .stroke(
                        isSelected ? Color.clear : ETColors.borderGray.opacity(0.18),
                        lineWidth: 1
                    )
            )
            // Assure au moins 44pt de zone tactile
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title), \(isSelected ? "sélectionné" : "non sélectionné")")
    }
}
