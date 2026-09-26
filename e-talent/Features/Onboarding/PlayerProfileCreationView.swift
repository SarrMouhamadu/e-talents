import SwiftUI

public struct PlayerProfileCreationView: View {
    @State private var fullName: String = ""
    @State private var selectedPosition: BasketballPosition = .pointGuard
    @State private var age: String = "18"
    @State private var height: String = "192"
    @State private var city: String = "Dakar"
    @State private var club: String = ""
    @State private var isAvailable: Bool = true
    @State private var bio: String = ""
    
    public var onComplete: () -> Void
    
    public init(onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
    }
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: ETSpacing.standard) {
                    // En-tête
                    VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                        Text("Création de votre fiche")
                            .font(ETTypography.largeTitle)
                            .foregroundColor(ETColors.pureWhite)
                        
                        Text("Ces informations permettront aux coachs de vous découvrir rapidement.")
                            .font(ETTypography.body)
                            .foregroundColor(ETColors.secondaryText)
                    }
                    .padding(.top, ETSpacing.standard)
                    
                    // Photo de profil bouton interactif
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            VStack(spacing: ETSpacing.xSmall) {
                                ZStack {
                                    Circle()
                                        .fill(ETColors.darkSurface)
                                        .frame(width: 90, height: 90)
                                        .overlay(
                                            Circle().stroke(ETColors.primaryOrange, lineWidth: 1.5)
                                        )
                                    
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 26))
                                        .foregroundColor(ETColors.primaryOrange)
                                }
                                
                                Text("Ajouter une photo")
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.primaryOrange)
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Ajouter une photo de profil")
                        Spacer()
                    }
                    
                    // Formulaire
                    VStack(spacing: ETSpacing.standard) {
                        ETTextField(
                            title: "Nom complet",
                            placeholder: "Ex: Cheikh Tidiane Diop",
                            icon: "person.fill",
                            text: $fullName
                        )
                        
                        // Sélection du poste
                        VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                            Text("Poste de prédilection")
                                .font(ETTypography.callout)
                                .foregroundColor(ETColors.secondaryText)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: ETSpacing.xSmall) {
                                    ForEach(BasketballPosition.allCases) { pos in
                                        ETFilterChip(
                                            "\(pos.shortCode) - \(pos.rawValue)",
                                            isSelected: selectedPosition == pos,
                                            action: { selectedPosition = pos }
                                        )
                                    }
                                }
                            }
                        }
                        
                        // Taille et Âge avec pavé numérique
                        HStack(spacing: ETSpacing.standard) {
                            ETTextField(
                                title: "Taille (cm)",
                                placeholder: "192",
                                icon: "ruler",
                                text: $height,
                                keyboardType: .numberPad
                            )
                            
                            ETTextField(
                                title: "Âge",
                                placeholder: "18",
                                icon: "calendar",
                                text: $age,
                                keyboardType: .numberPad
                            )
                        }
                        
                        ETTextField(
                            title: "Ville",
                            placeholder: "Ex: Dakar, Thiès, Saint-Louis...",
                            icon: "mappin.and.ellipse",
                            text: $city
                        )
                        
                        ETTextField(
                            title: "Club actuel (laisser vide si sans club)",
                            placeholder: "Ex: AS Douanes, AS Pikine...",
                            icon: "shield.fill",
                            text: $club
                        )
                        
                        ETTextField(
                            title: "Courte bio sportive (optionnel)",
                            placeholder: "Ex: Meneur rapide, focus tir 3pts et défense...",
                            icon: "text.quote",
                            text: $bio
                        )
                        
                        // Toggle Disponibilité
                        Toggle(isOn: $isAvailable) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Je cherche un club / disponible")
                                    .font(ETTypography.subheadlineBold)
                                    .foregroundColor(ETColors.pureWhite)
                                Text("Badge visible sur votre fiche athlète")
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.secondaryText)
                            }
                        }
                        .tint(ETColors.primaryOrange)
                        .padding(ETSpacing.standard)
                        .background(ETColors.darkSurface)
                        .cornerRadius(ETRadius.button)
                    }
                    
                    // Bouton Finaliser
                    ETButton("Valider et commencer", icon: "checkmark", style: .primary, size: .large) {
                        onComplete()
                    }
                    .disabled(fullName.trimmingCharacters(in: .whitespaces).isEmpty)
                    .padding(.top, ETSpacing.small)
                    .padding(.bottom, ETSpacing.large)
                }
                .padding(.horizontal, ETSpacing.standard)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
