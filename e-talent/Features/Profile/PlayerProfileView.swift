import SwiftUI

public struct PlayerProfileView: View {
    public let initialPlayer: Player
    public var isCurrentUser: Bool = false
    
    @State private var player: Player
    @State private var selectedTab: ProfileContentTab = .posts
    @State private var isAvailableForRecruiting: Bool = true
    @State private var activeConversation: Conversation?
    @State private var showEditProfile: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    public enum ProfileContentTab: String, CaseIterable {
        case posts = "Publications"
        case media = "Vidéos & Photos"
        case info = "Informations"
    }
    
    public init(player: Player, isCurrentUser: Bool = false) {
        self.initialPlayer = player
        self.isCurrentUser = isCurrentUser
        self._player = State(initialValue: player)
        self._isAvailableForRecruiting = State(initialValue: player.isAvailable)
    }
    
    private var isFollowing: Bool {
        MockDataService.shared.isFollowing(playerId: player.id)
    }
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: ETSpacing.standard) {
                    // MARK: - Header Profile (Avatar, Nom, Badges)
                    VStack(spacing: ETSpacing.small) {
                        ETAvatar(
                            name: player.name,
                            imageName: player.avatarUrl,
                            size: .xLarge,
                            isVerified: player.isVerified,
                            isAvailable: isCurrentUser ? isAvailableForRecruiting : player.isAvailable,
                            showAvailability: true
                        )
                        
                        VStack(spacing: 4) {
                            HStack(spacing: ETSpacing.xxSmall) {
                                Text(player.name)
                                    .font(ETTypography.largeTitle)
                                    .foregroundColor(ETColors.pureWhite)
                                
                                if player.isVerified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(ETColors.primaryOrange)
                                }
                            }
                            
                            // Club ou Statut
                            if let club = player.clubName, !club.isEmpty {
                                Text(club)
                                    .font(ETTypography.headline)
                                    .foregroundColor(ETColors.primaryOrange)
                            } else {
                                Text("Sans club actuellement")
                                    .font(ETTypography.callout)
                                    .foregroundColor(ETColors.secondaryText)
                            }
                        }
                    }
                    .padding(.top, ETSpacing.standard)
                    
                    // MARK: - Badges Caractéristiques Clés (Poste, Taille, Ville, Âge)
                    HStack(spacing: ETSpacing.small) {
                        statBadge(title: "Poste", value: player.position.shortCode)
                        statBadge(title: "Taille", value: player.formattedHeight)
                        statBadge(title: "Âge", value: "\(player.age) ans")
                        statBadge(title: "Ville", value: player.city)
                    }
                    .padding(.horizontal, ETSpacing.standard)
                    
                    // MARK: - Disponibilité & Actions
                    if isCurrentUser {
                        // Switch Disponibilité intégré proprement pour l'utilisateur connecté
                        Toggle(isOn: $isAvailableForRecruiting) {
                            HStack(spacing: ETSpacing.small) {
                                Circle()
                                    .fill(isAvailableForRecruiting ? ETColors.success : ETColors.secondaryText)
                                    .frame(width: 8, height: 8)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Disponible pour recrutement")
                                        .font(ETTypography.subheadlineBold)
                                        .foregroundColor(ETColors.pureWhite)
                                    Text("Visible par les clubs et coachs")
                                        .font(ETTypography.caption)
                                        .foregroundColor(ETColors.secondaryText)
                                }
                            }
                        }
                        .tint(ETColors.primaryOrange)
                        .padding(ETSpacing.standard)
                        .background(ETColors.darkSurface)
                        .cornerRadius(ETRadius.card)
                        .padding(.horizontal, ETSpacing.standard)
                        
                        // Point 6: Modifier mon profil
                        ETButton(
                            "Modifier mon profil",
                            icon: "pencil",
                            style: .secondary,
                            size: .medium
                        ) {
                            showEditProfile = true
                        }
                        .padding(.horizontal, ETSpacing.standard)
                    } else {
                        // État pour un visiteur tiers
                        HStack(spacing: ETSpacing.small) {
                            if player.isAvailable {
                                ETBadge("Disponible pour recrutement", icon: "checkmark.circle.fill", style: .success)
                            } else {
                                ETBadge("Sous contrat club", icon: "lock.fill", style: .neutral)
                            }
                        }
                        
                        HStack(spacing: ETSpacing.standard) {
                            // Point 1: Contacter le joueur
                            ETButton(
                                "Contacter",
                                icon: "paperplane.fill",
                                style: .primary,
                                size: .medium
                            ) {
                                openChat()
                            }
                            
                            // Point 2: Suivre le joueur
                            ETButton(
                                isFollowing ? "Abonné" : "Suivre",
                                icon: isFollowing ? "checkmark" : "plus",
                                style: isFollowing ? .outline : .secondary,
                                size: .medium
                            ) {
                                MockDataService.shared.toggleFollow(playerId: player.id)
                            }
                        }
                        .padding(.horizontal, ETSpacing.standard)
                    }
                    
                    // MARK: - Bio
                    if !player.bio.isEmpty {
                        VStack(alignment: .leading, spacing: ETSpacing.xxSmall) {
                            Text("À propos")
                                .font(ETTypography.headline)
                                .foregroundColor(ETColors.pureWhite)
                            
                            Text(player.bio)
                                .font(ETTypography.body)
                                .foregroundColor(ETColors.secondaryText)
                                .lineSpacing(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(ETSpacing.standard)
                        .background(ETColors.darkSurface)
                        .cornerRadius(ETRadius.card)
                        .padding(.horizontal, ETSpacing.standard)
                    }
                    
                    // MARK: - Onglets de contenu
                    HStack(spacing: ETSpacing.standard) {
                        ForEach(ProfileContentTab.allCases, id: \.self) { tab in
                            Button(action: { selectedTab = tab }) {
                                VStack(spacing: 8) {
                                    Text(tab.rawValue)
                                        .font(ETTypography.subheadlineBold)
                                        .foregroundColor(selectedTab == tab ? ETColors.primaryOrange : ETColors.secondaryText)
                                    
                                    Rectangle()
                                        .fill(selectedTab == tab ? ETColors.primaryOrange : Color.clear)
                                        .frame(height: 2)
                                }
                                .frame(minHeight: 44)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("\(tab.rawValue), onglet \(selectedTab == tab ? "sélectionné" : "")")
                        }
                    }
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.top, ETSpacing.small)
                    
                    // MARK: - Contenu des onglets
                    switch selectedTab {
                    case .posts:
                        let playerPosts = MockDataService.shared.posts.filter { $0.authorName == player.name }
                        if playerPosts.isEmpty {
                            ETEmptyState(
                                icon: "video.slash",
                                title: "Aucune publication",
                                description: "Ce joueur n'a pas encore partagé de publication."
                            )
                        } else {
                            ForEach(playerPosts) { post in
                                ETPostCard(post: post)
                                    .padding(.horizontal, ETSpacing.standard)
                            }
                        }
                        
                    case .media:
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: ETSpacing.small) {
                            ForEach(0..<6, id: \.self) { index in
                                RoundedRectangle(cornerRadius: ETRadius.media)
                                    .fill(ETColors.darkSurface)
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(
                                        VStack(spacing: 6) {
                                            Image(systemName: index % 2 == 0 ? "play.circle.fill" : "basketball.fill")
                                                .font(.system(size: 28))
                                                .foregroundColor(ETColors.primaryOrange)
                                            Text(index % 2 == 0 ? "Highlight #\(index + 1)" : "Photo match")
                                                .font(ETTypography.caption)
                                                .foregroundColor(ETColors.secondaryText)
                                        }
                                    )
                            }
                        }
                        .padding(.horizontal, ETSpacing.standard)
                        
                    case .info:
                        VStack(spacing: ETSpacing.small) {
                            infoRow(title: "Poste principal", value: player.position.rawValue)
                            infoRow(title: "Taille", value: player.formattedHeight)
                            infoRow(title: "Âge", value: "\(player.age) ans")
                            infoRow(title: "Ville", value: player.city)
                            infoRow(title: "Statut", value: player.clubOrStatus)
                        }
                        .padding(ETSpacing.standard)
                        .background(ETColors.darkSurface)
                        .cornerRadius(ETRadius.card)
                        .padding(.horizontal, ETSpacing.standard)
                    }
                }
                .padding(.bottom, ETSpacing.xxLarge)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if !isCurrentUser {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(ETColors.pureWhite)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .accessibilityLabel("Fermer le profil")
                }
            }
        }
        .sheet(item: $activeConversation) { conv in
            NavigationStack {
                ChatDetailView(conversation: conv)
            }
        }
        .sheet(isPresented: $showEditProfile) {
            EditProfileView(player: $player)
        }
    }
    
    private func openChat() {
        let conv = MockDataService.shared.getOrCreateConversation(
            for: player.name,
            role: "Joueur",
            club: player.clubName,
            isVerified: player.isVerified
        )
        activeConversation = conv
    }
    
    private func statBadge(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(ETTypography.headline)
                .foregroundColor(ETColors.pureWhite)
            Text(title)
                .font(ETTypography.caption)
                .foregroundColor(ETColors.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(ETColors.darkSurface)
        .cornerRadius(ETRadius.button)
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(ETTypography.callout)
                .foregroundColor(ETColors.secondaryText)
            Spacer()
            Text(value)
                .font(ETTypography.body)
                .fontWeight(.medium)
                .foregroundColor(ETColors.pureWhite)
        }
        .padding(.vertical, 4)
    }
}
