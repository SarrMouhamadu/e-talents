import Foundation

public enum PostMediaType: String, Codable {
    case photo
    case video
    case none
}

public struct PostComment: Identifiable, Hashable, Codable {
    public let id: String
    public var authorName: String
    public var authorRole: String
    public var text: String
    public var timeAgo: String
    public var isVerified: Bool
    
    public init(
        id: String = UUID().uuidString,
        authorName: String,
        authorRole: String = "Joueur",
        text: String,
        timeAgo: String = "À l'instant",
        isVerified: Bool = false
    ) {
        self.id = id
        self.authorName = authorName
        self.authorRole = authorRole
        self.text = text
        self.timeAgo = timeAgo
        self.isVerified = isVerified
    }
}

public struct Post: Identifiable, Hashable, Codable {
    public let id: String
    public var authorId: String
    public var authorName: String
    public var authorHandle: String
    public var authorRole: String // "Joueur" ou "Club"
    public var authorClub: String?
    public var authorPosition: String?
    public var representativeName: String?
    public var representativeRole: String?
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
    public var comments: [PostComment]
    public var imageData: Data?
    public var authorAvatarUrl: String?
    public var imageName: String?
    
    public init(
        id: String = UUID().uuidString,
        authorId: String,
        authorName: String,
        authorHandle: String,
        authorRole: String = "Joueur",
        authorClub: String? = nil,
        authorPosition: String? = nil,
        representativeName: String? = nil,
        representativeRole: String? = nil,
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
        isBookmarked: Bool = false,
        comments: [PostComment] = [],
        imageData: Data? = nil,
        authorAvatarUrl: String? = nil,
        imageName: String? = nil
    ) {
        self.id = id
        self.authorId = authorId
        self.authorName = authorName
        self.authorHandle = authorHandle
        self.authorRole = authorRole
        self.authorClub = authorClub
        self.authorPosition = authorPosition
        self.representativeName = representativeName
        self.representativeRole = representativeRole
        self.isAuthorVerified = isAuthorVerified
        self.timeAgo = timeAgo
        self.content = content
        self.mediaType = mediaType
        self.mediaPlaceholderColor = mediaPlaceholderColor
        self.mediaAspectRatio = mediaAspectRatio
        self.mediaCaption = mediaCaption
        self.likesCount = likesCount
        self.commentsCount = commentsCount > 0 ? commentsCount : comments.count
        self.isLiked = isLiked
        self.isBookmarked = isBookmarked
        self.comments = comments
        self.imageData = imageData
        self.authorAvatarUrl = authorAvatarUrl
        self.imageName = imageName
    }
}
