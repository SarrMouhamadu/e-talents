import Foundation
import SwiftUI
import Observation

@Observable
public final class MockDataService {
    public static let shared = MockDataService()
    
    public var posts: [Post] = MockData.samplePosts
    public var players: [Player] = MockData.samplePlayers
    public var clubs: [Club] = MockData.sampleClubs
    public var conversations: [Conversation] = MockData.sampleConversations
    public var notifications: [NotificationItem] = MockData.sampleNotifications
    
    // Suivis (Following)
    public var followedPlayerIds: Set<String> = []
    public var followedClubIds: Set<String> = []
    
    public var isLoadingFeed: Bool = false
    public var isLoadingDiscover: Bool = false
    
    public init() {}
    
    // MARK: - Feed
    public func fetchFeed() async {
        isLoadingFeed = true
        // Simule une latence réseau réaliste
        try? await Task.sleep(nanoseconds: 600_000_000)
        isLoadingFeed = false
    }
    
    public func toggleLike(for postId: String) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isLiked.toggle()
            posts[index].likesCount += posts[index].isLiked ? 1 : -1
        }
    }
    
    public func toggleBookmark(for postId: String) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isBookmarked.toggle()
        }
    }
    
    public func addComment(to postId: String, text: String, authorName: String = "Mamadou Sarr") {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            let newComment = PostComment(
                authorName: authorName,
                authorRole: "Joueur",
                text: trimmed,
                timeAgo: "À l'instant",
                isVerified: true
            )
            posts[index].comments.insert(newComment, at: 0)
            posts[index].commentsCount += 1
        }
    }
    
    public func addPost(
        content: String,
        mediaType: PostMediaType,
        caption: String? = nil,
        imageData: Data? = nil,
        aspectRatio: Double? = nil
    ) {
        var calculatedRatio: Double = mediaType == .video ? 1.77 : 1.0
        if let explicitRatio = aspectRatio {
            calculatedRatio = explicitRatio
        } else if let imageData, let uiImage = UIImage(data: imageData), uiImage.size.height > 0 {
            let naturalRatio = Double(uiImage.size.width / uiImage.size.height)
            // Clamp entre 0.8 (portrait 4:5) et 1.91 (paysage) pour un rendu visuel optimal
            calculatedRatio = max(0.8, min(1.91, naturalRatio))
        } else if mediaType == .photo {
            calculatedRatio = 1.0 // Format carré harmonieux par défaut
        }

        let newPost = Post(
            id: UUID().uuidString,
            authorId: "current_user",
            authorName: "Mamadou Sarr",
            authorHandle: "@mamadou.sarr",
            authorRole: "Joueur",
            authorClub: nil,
            authorPosition: "Ailier fort",
            isAuthorVerified: true,
            timeAgo: "À l'instant",
            content: content,
            mediaType: mediaType,
            mediaAspectRatio: calculatedRatio,
            mediaCaption: caption ?? (mediaType == .video ? "Session Highlight" : "Photo du jour"),
            likesCount: 0,
            commentsCount: 0,
            isLiked: false,
            isBookmarked: false,
            comments: [],
            imageData: imageData
        )
        posts.insert(newPost, at: 0)
    }
    
    // MARK: - Suivre / Ne plus suivre
    public func isFollowing(playerId: String) -> Bool {
        followedPlayerIds.contains(playerId)
    }
    
    @discardableResult
    public func toggleFollow(playerId: String) -> Bool {
        if followedPlayerIds.contains(playerId) {
            followedPlayerIds.remove(playerId)
            if let index = players.firstIndex(where: { $0.id == playerId }) {
                players[index].followersCount = max(0, players[index].followersCount - 1)
            }
            return false
        } else {
            followedPlayerIds.insert(playerId)
            if let index = players.firstIndex(where: { $0.id == playerId }) {
                players[index].followersCount += 1
            }
            return true
        }
    }
    
    public func isFollowingClub(clubId: String) -> Bool {
        followedClubIds.contains(clubId)
    }
    
    @discardableResult
    public func toggleFollowClub(clubId: String) -> Bool {
        if followedClubIds.contains(clubId) {
            followedClubIds.remove(clubId)
            if let index = clubs.firstIndex(where: { $0.id == clubId }) {
                clubs[index].followersCount = max(0, clubs[index].followersCount - 1)
            }
            return false
        } else {
            followedClubIds.insert(clubId)
            if let index = clubs.firstIndex(where: { $0.id == clubId }) {
                clubs[index].followersCount += 1
            }
            return true
        }
    }
    
    // MARK: - Conversations / Messagerie
    public func getOrCreateConversation(
        for participantName: String,
        role: String = "Joueur",
        club: String? = nil,
        isVerified: Bool = false
    ) -> Conversation {
        if let existing = conversations.first(where: { $0.participantName.localizedCaseInsensitiveContains(participantName) }) {
            return existing
        }
        
        let newConv = Conversation(
            id: UUID().uuidString,
            participantName: participantName,
            participantRole: role,
            participantClub: club,
            isVerified: isVerified,
            lastMessage: "Conversation démarrée",
            timeAgo: "À l'instant",
            unreadCount: 0
        )
        conversations.insert(newConv, at: 0)
        return newConv
    }
    
    // MARK: - Mise à jour Joueur / Profil
    public func updatePlayer(_ updated: Player) {
        if let index = players.firstIndex(where: { $0.id == updated.id }) {
            players[index] = updated
        }
    }
    
    // MARK: - Discover Filter
    public func searchPlayers(
        query: String = "",
        position: BasketballPosition? = nil,
        city: String? = nil,
        availableOnly: Bool = false
    ) -> [Player] {
        players.filter { player in
            let matchesQuery = query.isEmpty ||
                player.name.localizedCaseInsensitiveContains(query) ||
                player.city.localizedCaseInsensitiveContains(query) ||
                (player.clubName?.localizedCaseInsensitiveContains(query) ?? false)
            
            let matchesPosition = position == nil || player.position == position
            let matchesCity = city == nil || player.city.localizedCaseInsensitiveContains(city ?? "")
            let matchesAvailable = !availableOnly || player.isAvailable
            
            return matchesQuery && matchesPosition && matchesCity && matchesAvailable
        }
    }
    
    public func searchClubs(query: String = "") -> [Club] {
        clubs.filter { club in
            query.isEmpty ||
                club.name.localizedCaseInsensitiveContains(query) ||
                club.city.localizedCaseInsensitiveContains(query)
        }
    }
}
