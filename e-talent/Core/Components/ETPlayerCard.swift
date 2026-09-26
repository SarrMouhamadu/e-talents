import SwiftUI

public struct ETPlayerCard: View {
    public let player: Player
    public var onSelect: (() -> Void)?
    
    public init(player: Player, onSelect: (() -> Void)? = nil) {
        self.player = player
        self.onSelect = onSelect
    }
    
    public var body: some View {
        Button(action: { onSelect?() }) {
            HStack(spacing: ETSpacing.standard) {
                // Avatar avec indicateur
                ETAvatar(
                    name: player.name,
                    imageName: player.avatarUrl,
                    size: .medium,
                    isVerified: player.isVerified,
                    isAvailable: player.isAvailable,
                    showAvailability: true
                )
                
                // Infos Joueur
                VStack(alignment: .leading, spacing: ETSpacing.xxSmall) {
                    HStack(spacing: ETSpacing.xSmall) {
                        Text(player.name)
                            .font(ETTypography.subheadlineBold)
                            .foregroundColor(ETColors.pureWhite)
                            .lineLimit(1)
                        
                        if player.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 13))
                                .foregroundColor(ETColors.primaryOrange)
                        }
                    }
                    
                    // Position • Âge • Taille
                    Text("\(player.position.rawValue) (\(player.position.shortCode)) • \(player.age) ans • \(player.formattedHeight)")
                        .font(ETTypography.caption)
                        .foregroundColor(ETColors.secondaryText)
                        .lineLimit(1)
                    
                    // Ville & Club ou Disponibilité
                    HStack(spacing: ETSpacing.xSmall) {
                        HStack(spacing: 3) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 10))
                            Text(player.city)
                                .font(ETTypography.caption)
                        }
                        .foregroundColor(ETColors.secondaryText)
                        
                        Text("•")
                            .font(ETTypography.caption)
                            .foregroundColor(ETColors.secondaryText)
                        
                        if player.isAvailable {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(ETColors.success)
                                    .frame(width: 6, height: 6)
                                Text("Disponible")
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.success)
                            }
                        } else if let club = player.clubName, !club.isEmpty {
                            Text(club)
                                .font(ETTypography.caption)
                                .foregroundColor(ETColors.primaryOrange)
                        } else {
                            Text("Sans club")
                                .font(ETTypography.caption)
                                .foregroundColor(ETColors.secondaryText)
                        }
                    }
                }
                
                Spacer()
                
                // Chevron de navigation
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(ETColors.secondaryText.opacity(0.6))
            }
            .padding(ETSpacing.standard)
            .frame(minHeight: 74)
            .background(ETColors.darkSurface)
            .cornerRadius(ETRadius.card)
            .overlay(
                RoundedRectangle(cornerRadius: ETRadius.card)
                    .stroke(ETColors.borderGray.opacity(0.12), lineWidth: 1)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(player.name), \(player.isVerified ? "profil vérifié," : "") \(player.position.rawValue), \(player.formattedHeight), \(player.age) ans, \(player.city), \(player.clubOrStatus)")
        .accessibilityHint("Double tapez pour afficher la fiche complète")
    }
}
