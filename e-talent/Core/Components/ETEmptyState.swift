import SwiftUI

public struct ETEmptyState: View {
    private let icon: String
    private let title: String
    private let description: String
    private let buttonTitle: String?
    private let action: (() -> Void)?
    
    public init(
        icon: String = "basketball",
        title: String,
        description: String,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: ETSpacing.medium) {
            ZStack {
                Circle()
                    .fill(ETColors.darkSurface)
                    .frame(width: 80, height: 80)
                
                Image(systemName: icon)
                    .font(.system(size: 34))
                    .foregroundColor(ETColors.primaryOrange)
            }
            
            VStack(spacing: ETSpacing.xSmall) {
                Text(title)
                    .font(ETTypography.headline)
                    .foregroundColor(ETColors.pureWhite)
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(ETTypography.callout)
                    .foregroundColor(ETColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
            .padding(.horizontal, ETSpacing.large)
            
            if let buttonTitle = buttonTitle, let action = action {
                ETButton(
                    buttonTitle,
                    style: .secondary,
                    size: .medium,
                    isFullWidth: false,
                    action: action
                )
                .padding(.top, ETSpacing.small)
            }
        }
        .padding(ETSpacing.xxLarge)
    }
}
