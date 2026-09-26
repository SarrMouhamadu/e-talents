import SwiftUI

public struct ETTextField: View {
    private let title: String?
    private let placeholder: String
    private let icon: String?
    @Binding private var text: String
    private let errorMessage: String?
    private let isSecure: Bool
    private let keyboardType: UIKeyboardType
    
    @FocusState private var isFocused: Bool
    
    public init(
        title: String? = nil,
        placeholder: String,
        icon: String? = nil,
        text: Binding<String>,
        errorMessage: String? = nil,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) {
        self.title = title
        self.placeholder = placeholder
        self.icon = icon
        self._text = text
        self.errorMessage = errorMessage
        self.isSecure = isSecure
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
            if let title = title {
                Text(title)
                    .font(ETTypography.callout)
                    .foregroundColor(ETColors.secondaryText)
            }
            
            HStack(spacing: ETSpacing.small) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(isFocused ? ETColors.primaryOrange : ETColors.secondaryText)
                        .frame(width: 20)
                }
                
                if isSecure {
                    SecureField(
                        "",
                        text: $text,
                        prompt: Text(placeholder).foregroundColor(ETColors.secondaryText)
                    )
                    .font(ETTypography.body)
                    .foregroundColor(ETColors.pureWhite)
                    .focused($isFocused)
                    .keyboardType(keyboardType)
                } else {
                    TextField(
                        "",
                        text: $text,
                        prompt: Text(placeholder).foregroundColor(ETColors.secondaryText)
                    )
                    .font(ETTypography.body)
                    .foregroundColor(ETColors.pureWhite)
                    .focused($isFocused)
                    .keyboardType(keyboardType)
                }
                
                if !text.isEmpty {
                    Button(action: { text = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(ETColors.secondaryText)
                            .font(.system(size: 16))
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Effacer le texte")
                }
            }
            .padding(.horizontal, ETSpacing.standard)
            .frame(height: 50)
            .background(ETColors.darkSurface)
            .cornerRadius(ETRadius.button)
            .overlay(
                RoundedRectangle(cornerRadius: ETRadius.button)
                    .stroke(
                        errorMessage != nil ? ETColors.error :
                        (isFocused ? ETColors.primaryOrange : Color.clear),
                        lineWidth: 1.5
                    )
            )
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(ETTypography.caption)
                    .foregroundColor(ETColors.error)
            }
        }
    }
}
