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
                    // Logo officiel E-TALENT
                    Image("ETalentLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 160, maxHeight: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                        .shadow(color: ETColors.primaryOrange.opacity(0.25), radius: 18, x: 0, y: 6)
                        .accessibilityLabel("Logo officiel E-Talent")
                        .padding(.top, ETSpacing.large)
                    
                    // Titre & Slogan officiel
                    VStack(spacing: ETSpacing.xSmall) {
                        Text("E-TALENT")
                            .font(.system(size: 30, weight: .black, design: .rounded))
                            .foregroundColor(ETColors.pureWhite)
                            .tracking(2)
                        
                        Text("Crée ton profil. Montre ton talent. Fais-toi découvrir.")
                            .font(ETTypography.headline)
                            .foregroundColor(ETColors.primaryOrange)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, ETSpacing.standard)
                        
                        Text("Le réseau des talents et clubs du basketball sénégalais.")
                            .font(ETTypography.callout)
                            .foregroundColor(ETColors.secondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, ETSpacing.standard)
                            .padding(.top, 2)
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
