import Foundation

public enum PostMediaType: String, Codable {
    case photo
    case video
    case none
}

public struct Post: Identifiable, Hashable, Codable {
    public let id: String
    public var authorId: String
    public var authorName: String
    public var authorHandle: String
    public var authorRole: String // "Joueur" ou "Club"
    public var authorClub: String?
    public var authorPosition: String?
    public var isAuthorVerified: Bool
    public var timeAgo: String
    public var content: String
    public var mediaType: PostMediaType
    public var mediaPlaceholderColor: String?
    public var mediaAspectRatio: Double // e.g. 0.8 for 4:5, 1.77 for 16:9
    public var mediaCaption: String?
    public var likesCount: Int
    public var commentsCount: Int
    public var isLiked: Bool
    public var isBookmarked: Bool
    
    public init(
        id: String = UUID().uuidString,
        authorId: String,
        authorName: String,
        authorHandle: String,
        authorRole: String = "Joueur",
        authorClub: String? = nil,
        authorPosition: String? = nil,
        isAuthorVerified: Bool = false,
        timeAgo: String,
        content: String,
        mediaType: PostMediaType = .none,
        mediaPlaceholderColor: String? = nil,
        mediaAspectRatio: Double = 0.8,
        mediaCaption: String? = nil,
        likesCount: Int = 0,
        commentsCount: Int = 0,
        isLiked: Bool = false,
        isBookmarked: Bool = false
    ) {
        self.id = id
        self.authorId = authorId
        self.authorName = authorName
        self.authorHandle = authorHandle
        self.authorRole = authorRole
        self.authorClub = authorClub
        self.authorPosition = authorPosition
        self.isAuthorVerified = isAuthorVerified
        self.timeAgo = timeAgo
        self.content = content
        self.mediaType = mediaType
        self.mediaPlaceholderColor = mediaPlaceholderColor
        self.mediaAspectRatio = mediaAspectRatio
        self.mediaCaption = mediaCaption
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.isLiked = isLiked
        self.isBookmarked = isBookmarked
    }
}
