import SwiftUI

public struct WelcomeView: View {
    public var onStart: () -> Void
    public var onSkip: () -> Void
    
    public init(onStart: @escaping () -> Void, onSkip: @escaping () -> Void) {
        self.onStart = onStart
        self.onSkip = onSkip
    }
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: ETSpacing.large) {
                    // Hero Graphic
                    ZStack {
                        Circle()
                            .fill(ETColors.darkSurface)
                            .frame(width: 130, height: 130)
                            .overlay(
                                Circle().stroke(ETColors.primaryOrange.opacity(0.25), lineWidth: 1.5)
                            )
                        
                        Image(systemName: "figure.basketball")
                            .font(.system(size: 64))
                            .foregroundColor(ETColors.primaryOrange)
                    }
                    .padding(.top, ETSpacing.large)
                    
                    // Titre & Sous-titre
                    VStack(spacing: ETSpacing.small) {
                        Text("Révèle ton talent au basketball")
                            .font(ETTypography.largeTitle)
                            .foregroundColor(ETColors.pureWhite)
                            .multilineTextAlignment(.center)
                        
                        Text("La première plateforme dédiée aux basketteurs et clubs du Sénégal.")
                            .font(ETTypography.body)
                            .foregroundColor(ETColors.secondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, ETSpacing.standard)
                    }
                    
                    // Piliers de valeur
                    VStack(spacing: ETSpacing.standard) {
                        featureRow(
                            icon: "video.fill",
                            title: "Publie tes highlights",
                            subtitle: "Partage tes meilleures actions et vidéos d'entraînement."
                        )
                        featureRow(
                            icon: "shield.lefthalf.filled",
                            title: "Connecte-toi aux clubs",
                            subtitle: "Suis l'actualité de l'AS Douanes, Pikine, DUC et plus."
                        )
                        featureRow(
                            icon: "eye.fill",
                            title: "Fais-toi découvrir",
                            subtitle: "Sois visible auprès de la communauté et des clubs du basketball sénégalais."
                        )
                    }
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.vertical, ETSpacing.small)
                    
                    // Actions
                    VStack(spacing: ETSpacing.small) {
                        ETButton("Créer mon compte", icon: "arrow.right", style: .primary, size: .large) {
                            onStart()
                        }
                        
                        ETButton("Explorer l'application", style: .ghost, size: .medium) {
                            onSkip()
                        }
                    }
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.bottom, ETSpacing.large)
                }
            }
        }
    }
    
    private func featureRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: ETSpacing.standard) {
            ZStack {
                Circle()
                    .fill(ETColors.darkSurface)
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(ETColors.primaryOrange)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(ETTypography.subheadlineBold)
                    .foregroundColor(ETColors.pureWhite)
                
                Text(subtitle)
                    .font(ETTypography.caption)
                    .foregroundColor(ETColors.secondaryText)
            }
            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), \(subtitle)")
    }
}
