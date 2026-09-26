import SwiftUI

public struct ETClubCard: View {
    public let club: Club
    public var onSelect: (() -> Void)?
    
    public init(club: Club, onSelect: (() -> Void)? = nil) {
        self.club = club
        self.onSelect = onSelect
    }
    
    public var body: some View {
        Button(action: { onSelect?() }) {
            VStack(alignment: .leading, spacing: ETSpacing.small) {
                HStack(spacing: ETSpacing.standard) {
                    // Monogramme Club
                    ETAvatar(name: club.name, size: .medium, isVerified: club.isVerified)
                    
                    VStack(alignment: .leading, spacing: ETSpacing.xxSmall) {
                        HStack(spacing: ETSpacing.xSmall) {
                            Text(club.name)
                                .font(ETTypography.headline)
                                .foregroundColor(ETColors.pureWhite)
                                .lineLimit(1)
                            
                            if club.isVerified {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(ETColors.primaryOrange)
                            }
                        }
                        
                        Text("\(club.division) • \(club.city)")
                            .font(ETTypography.caption)
                            .foregroundColor(ETColors.secondaryText)
                    }
                    
                    Spacer()
                    
                    ETBadge("\(club.playersCount) Joueurs", style: .neutral)
                }
                
                Text(club.description)
                    .font(ETTypography.callout)
                    .foregroundColor(ETColors.secondaryText)
                    .lineLimit(2)
            }
            .padding(ETSpacing.standard)
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
        .accessibilityLabel("\(club.name), \(club.isVerified ? "club vérifié," : "") \(club.division), \(club.city), \(club.playersCount) joueurs inscrits")
        .accessibilityHint("Double tapez pour afficher la présentation du club")
    }
}
