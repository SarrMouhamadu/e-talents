import SwiftUI

public enum UserAccountType {
    case player
    case club
}

public struct AccountTypeView: View {
    @State private var selectedType: UserAccountType = .player
    public var onSelect: (UserAccountType) -> Void
    
    public init(onSelect: @escaping (UserAccountType) -> Void) {
        self.onSelect = onSelect
    }
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: ETSpacing.large) {
                    // En-tête
                    VStack(alignment: .leading, spacing: ETSpacing.small) {
                        Text("Qui êtes-vous ?")
                            .font(ETTypography.largeTitle)
                            .foregroundColor(ETColors.pureWhite)
                        
                        Text("Choisissez votre statut pour personnaliser votre expérience E-Talent.")
                            .font(ETTypography.body)
                            .foregroundColor(ETColors.secondaryText)
                    }
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.top, ETSpacing.large)
                    
                    // Choix 1: Joueur
                    accountCard(
                        type: .player,
                        title: "Je suis un Joueur",
                        subtitle: "Pour créer mon profil, publier mes performances et me faire découvrir.",
                        icon: "figure.basketball",
                        isSelected: selectedType == .player
                    )
                    
                    // Choix 2: Club
                    accountCard(
                        type: .club,
                        title: "Je représente un Club",
                        subtitle: "Pour présenter mon équipe, annoncer des détections et découvrir de nouveaux talents.",
                        icon: "shield.checkered",
                        isSelected: selectedType == .club
                    )
                    
                    // Bouton Continuer
                    ETButton("Continuer", icon: "arrow.right", style: .primary, size: .large) {
                        onSelect(selectedType)
                    }
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.top, ETSpacing.medium)
                    .padding(.bottom, ETSpacing.large)
                }
            }
        }
    }
    
    private func accountCard(
        type: UserAccountType,
        title: String,
        subtitle: String,
        icon: String,
        isSelected: Bool
    ) -> some View {
        Button(action: { selectedType = type }) {
            HStack(spacing: ETSpacing.standard) {
                ZStack {
                    Circle()
                        .fill(isSelected ? ETColors.primaryOrange.opacity(0.15) : ETColors.darkSurface)
                        .frame(width: 52, height: 52)
                    
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(isSelected ? ETColors.primaryOrange : ETColors.secondaryText)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(ETTypography.headline)
                        .foregroundColor(ETColors.pureWhite)
                    
                    Text(subtitle)
                        .font(ETTypography.caption)
                        .foregroundColor(ETColors.secondaryText)
                        .lineSpacing(2)
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? ETColors.primaryOrange : ETColors.secondaryText.opacity(0.4))
            }
            .padding(ETSpacing.standard)
            .background(ETColors.darkSurface)
            .cornerRadius(ETRadius.card)
            .overlay(
                RoundedRectangle(cornerRadius: ETRadius.card)
                    .stroke(isSelected ? ETColors.primaryOrange : ETColors.borderGray.opacity(0.15), lineWidth: 1.5)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, ETSpacing.standard)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), \(subtitle), \(isSelected ? "sélectionné" : "non sélectionné")")
        .accessibilityHint("Double tapez pour sélectionner cette option")
    }
}
