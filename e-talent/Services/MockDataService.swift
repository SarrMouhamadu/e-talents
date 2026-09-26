import Foundation
import Observation

@Observable
public final class MockDataService {
    public static let shared = MockDataService()
    
    public var posts: [Post] = MockData.samplePosts
    public var players: [Player] = MockData.samplePlayers
    public var clubs: [Club] = MockData.sampleClubs
    public var conversations: [Conversation] = MockData.sampleConversations
    public var notifications: [NotificationItem] = MockData.sampleNotifications
    
    public var isLoadingFeed: Bool = false
    public var isLoadingDiscover: Bool = false
    
    public init() {}
    
    // MARK: - Feed
    public func fetchFeed() async {
        isLoadingFeed = true
        // Simule une latence réseau réaliste
        try? await Task.sleep(nanoseconds: 600_000_000)
        self.posts = MockData.samplePosts
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
    
    public func addPost(content: String, mediaType: PostMediaType) {
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
            mediaAspectRatio: mediaType == .video ? 1.77 : 0.8,
            mediaCaption: "Session E-Talent",
            likesCount: 0,
            commentsCount: 0,
            isLiked: false,
            isBookmarked: false
        )
        posts.insert(newPost, at: 0)
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
