import SwiftUI

public struct ClubProfileView: View {
    public let club: Club
    public var isCurrentClub: Bool
    @State private var selectedPlayer: Player?
    @State private var activeConversation: Conversation?
    @Environment(\.dismiss) private var dismiss
    
    public init(club: Club, isCurrentClub: Bool = false) {
        self.club = club
        self.isCurrentClub = isCurrentClub
    }
    
    private var isFollowing: Bool {
        MockDataService.shared.isFollowingClub(clubId: club.id)
    }
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: ETSpacing.standard) {
                    // Header Club
                    VStack(spacing: ETSpacing.small) {
                        if let data = club.logoData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(ETColors.primaryOrange, lineWidth: 2))
                        } else {
                            ETAvatar(name: club.name, size: .xLarge, isVerified: club.isVerified)
                        }
                        
                        VStack(spacing: 4) {
                            HStack(spacing: ETSpacing.xxSmall) {
                                Text(club.name)
                                    .font(ETTypography.largeTitle)
                                    .foregroundColor(ETColors.pureWhite)
                                
                                if club.isVerified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(ETColors.primaryOrange)
                                }
                            }
                            
                            Text("\(club.division) • \(club.city)")
                                .font(ETTypography.callout)
                                .foregroundColor(ETColors.secondaryText)
                        }
                    }
                    .padding(.top, ETSpacing.standard)
                    
                    // Représentant officiel (pour les clubs)
                    if let repName = club.representativeName {
                        HStack(spacing: ETSpacing.small) {
                            Image(systemName: "person.crop.circle.badge.checkmark")
                                .font(.system(size: 22))
                                .foregroundColor(ETColors.primaryOrange)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Contact officiel du club")
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.secondaryText)
                                
                                Text("\(repName) • \(club.representativeRole ?? "Dirigeant")")
                                    .font(ETTypography.subheadlineBold)
                                    .foregroundColor(ETColors.pureWhite)
                            }
                            
                            Spacer()
                        }
                        .padding(ETSpacing.small)
                        .background(ETColors.darkSurface)
                        .cornerRadius(ETRadius.card)
                        .padding(.horizontal, ETSpacing.standard)
                    }
                    
                    // Actions (Gérer si profil propre, sinon Suivre et Contacter)
                    if isCurrentClub {
                        HStack(spacing: ETSpacing.standard) {
                            ETButton("Annoncer une détection", icon: "megaphone.fill", style: .primary, size: .medium) {
                                // Action détection
                            }
                        }
                        .padding(.horizontal, ETSpacing.standard)
                    } else {
                        HStack(spacing: ETSpacing.standard) {
                            ETButton(
                                isFollowing ? "Abonné" : "Suivre le club",
                                icon: isFollowing ? "checkmark" : "plus",
                                style: isFollowing ? .outline : .primary,
                                size: .medium
                            ) {
                                MockDataService.shared.toggleFollowClub(clubId: club.id)
                            }
                            
                            ETButton("Contacter", icon: "paperplane.fill", style: .secondary, size: .medium) {
                                openChat()
                            }
                        }
                        .padding(.horizontal, ETSpacing.standard)
                    }
                    
                    // Description
                    VStack(alignment: .leading, spacing: ETSpacing.xxSmall) {
                        Text("Présentation du club")
                            .font(ETTypography.headline)
                            .foregroundColor(ETColors.pureWhite)
                        
                        Text(club.description)
                            .font(ETTypography.body)
                            .foregroundColor(ETColors.secondaryText)
                            .lineSpacing(3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(ETSpacing.standard)
                    .background(ETColors.darkSurface)
                    .cornerRadius(ETRadius.card)
                    .padding(.horizontal, ETSpacing.standard)
                    
                    // Effectif des joueurs
                    VStack(alignment: .leading, spacing: ETSpacing.small) {
                        HStack {
                            Text("EFFECTIF DES JOUEURS")
                                .font(ETTypography.caption)
                                .fontWeight(.bold)
                                .foregroundColor(ETColors.secondaryText)
                            
                            Spacer()
                            
                            Text("\(club.playersCount) inscrits")
                                .font(ETTypography.caption)
                                .foregroundColor(ETColors.primaryOrange)
                        }
                        .padding(.horizontal, ETSpacing.standard)
                        
                        let clubPlayers = MockData.samplePlayers.filter { $0.clubName == club.name }
                        if clubPlayers.isEmpty {
                            ETEmptyState(
                                icon: "person.3.sequence",
                                title: "Effectif en cours de validation",
                                description: "Les joueurs de ce club seront affichés ici dès leur enregistrement."
                            )
                        } else {
                            ForEach(clubPlayers) { player in
                                ETPlayerCard(player: player) {
                                    selectedPlayer = player
                                }
                                .padding(.horizontal, ETSpacing.standard)
                            }
                        }
                    }
                }
                .padding(.bottom, ETSpacing.xxLarge)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(ETColors.pureWhite)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .accessibilityLabel("Fermer la présentation du club")
            }
        }
        .sheet(item: $selectedPlayer) { player in
            NavigationStack {
                PlayerProfileView(player: player)
            }
        }
        .sheet(item: $activeConversation) { conv in
            NavigationStack {
                ChatDetailView(conversation: conv)
            }
        }
    }
    
    private func openChat() {
        let conv = MockDataService.shared.getOrCreateConversation(
            for: club.name,
            role: "Club",
            club: nil,
            isVerified: club.isVerified
        )
        activeConversation = conv
    }
}
