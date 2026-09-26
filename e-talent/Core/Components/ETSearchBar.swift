import SwiftUI

public struct ETSearchBar: View {
    @Binding private var text: String
    private let placeholder: String
    
    public init(text: Binding<String>, placeholder: String = "Rechercher un joueur ou un club") {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        HStack(spacing: ETSpacing.small) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundColor(ETColors.secondaryText)
            
            TextField(placeholder, text: $text)
                .font(ETTypography.body)
                .foregroundColor(ETColors.pureWhite)
                .autocorrectionDisabled()
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(ETColors.secondaryText)
                        .font(.system(size: 15))
                }
                .accessibilityLabel("Effacer la recherche")
            }
        }
        .padding(.horizontal, ETSpacing.standard)
        .frame(height: 46)
        .background(ETColors.darkSurface)
        .cornerRadius(ETRadius.button)
        .overlay(
            RoundedRectangle(cornerRadius: ETRadius.button)
                .stroke(ETColors.borderGray.opacity(0.15), lineWidth: 1)
        )
    }
}
