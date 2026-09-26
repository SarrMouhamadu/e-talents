import SwiftUI

public struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var selectedPlayer: Player?
    @State private var selectedPostForComments: Post?
    @State private var showNotifications: Bool = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // MARK: - Navigation Bar Custom
                    headerBar
                    
                    ScrollView {
                        LazyVStack(spacing: ETSpacing.standard) {
                            // MARK: - Talents à la une (Story-like avatars)
                            featuredTalentsSection
                                .padding(.top, ETSpacing.xSmall)
                            
                            // MARK: - Feed List ou Skeleton ou Erreur
                            if viewModel.isLoading {
                                ForEach(0..<3, id: \.self) { _ in
                                    ETPostCardSkeleton()
                                        .padding(.horizontal, ETSpacing.standard)
                                }
                            } else if let error = viewModel.errorMessage {
                                ETEmptyState(
                                    icon: "wifi.slash",
                                    title: "Connexion interrompue",
                                    description: error,
                                    buttonTitle: "Réessayer",
                                    action: { Task { await viewModel.loadFeed() } }
                                )
                                .padding(.top, ETSpacing.large)
                            } else if viewModel.posts.isEmpty {
                                ETEmptyState(
                                    icon: "basketball.fill",
                                    title: "Aucune publication",
                                    description: "Soyez le premier talent à partager une vidéo de vos entraînements ou de vos matchs.",
                                    buttonTitle: "Rafraîchir",
                                    action: { Task { await viewModel.loadFeed() } }
                                )
                                .padding(.top, ETSpacing.large)
                            } else {
                                ForEach(viewModel.posts) { post in
                                    ETPostCard(
                                        post: post,
                                        onLikeTapped: {
                                            viewModel.toggleLike(postId: post.id)
                                        },
                                        onCommentTapped: {
                                            selectedPostForComments = post
                                        },
                                        onBookmarkTapped: {
                                            viewModel.toggleBookmark(postId: post.id)
                                        },
                                        onAuthorTapped: {
                                            if let player = MockData.samplePlayers.first(where: { $0.id == post.authorId || $0.name == post.authorName }) {
                                                selectedPlayer = player
                                            }
                                        }
                                    )
                                    .padding(.horizontal, ETSpacing.standard)
                                }
                            }
                        }
                        .padding(.vertical, ETSpacing.standard)
                    }
                    .refreshable {
                        await viewModel.loadFeed()
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedPlayer) { player in
                NavigationStack {
                    PlayerProfileView(player: player)
                }
            }
            .sheet(item: $selectedPostForComments) { post in
                CommentsSheetView(post: post)
            }
            .sheet(isPresented: $showNotifications) {
                NavigationStack {
                    NotificationsView()
                }
            }
        }
    }
    
    // MARK: - Custom Header
    private var headerBar: some View {
        HStack {
            HStack(spacing: 6) {
                Text("E-TALENT")
                    .font(.system(size: 22, weight: .black, design: .rounded))
                    .foregroundColor(ETColors.pureWhite)
                
                // Discret accent identitaire Sénégal (3 micro pastilles)
                HStack(spacing: 3) {
                    Circle().fill(ETColors.senegalGreen).frame(width: 5, height: 5)
                    Circle().fill(ETColors.senegalYellow).frame(width: 5, height: 5)
                    Circle().fill(ETColors.senegalRed).frame(width: 5, height: 5)
                }
            }
            
            Spacer()
            
            // Bouton Notifications
            Button(action: { showNotifications = true }) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell")
                        .font(.system(size: 20))
                        .foregroundColor(ETColors.pureWhite)
                        .frame(width: 44, height: 44)
                    
                    // Pastille non lu
                    Circle()
                        .fill(ETColors.primaryOrange)
                        .frame(width: 8, height: 8)
                        .offset(x: -8, y: 10)
                }
                .contentShape(Rectangle())
            }
            .accessibilityLabel("Notifications, vous avez des alertes non lues")
        }
        .padding(.horizontal, ETSpacing.standard)
        .frame(height: 52)
        .background(ETColors.background)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(ETColors.borderGray.opacity(0.1)),
            alignment: .bottom
        )
    }
    
    // MARK: - Featured Talents (Carrousel Horizontal)
    private var featuredTalentsSection: some View {
        VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
            HStack {
                Text("TALENTS À DÉCOUVRIR")
                    .font(ETTypography.caption)
                    .fontWeight(.bold)
                    .foregroundColor(ETColors.secondaryText)
                Spacer()
            }
            .padding(.horizontal, ETSpacing.standard)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: ETSpacing.standard) {
                    ForEach(MockData.samplePlayers) { player in
                        Button(action: { selectedPlayer = player }) {
                            VStack(spacing: 6) {
                                ETAvatar(
                                    name: player.name,
                                    size: .medium,
                                    isVerified: player.isVerified,
                                    isAvailable: player.isAvailable,
                                    showAvailability: true
                                )
                                
                                Text(player.name.components(separatedBy: " ").first ?? player.name)
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.pureWhite)
                                    .lineLimit(1)
                                
                                Text(player.position.shortCode)
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(ETColors.primaryOrange)
                            }
                            .frame(width: 72)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(player.name), poste \(player.position.rawValue)")
                        .accessibilityHint("Double tapez pour ouvrir la fiche de ce talent")
                    }
                }
                .padding(.horizontal, ETSpacing.standard)
            }
        }
    }
}
