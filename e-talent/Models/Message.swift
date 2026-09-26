import Foundation

public struct ChatMessage: Identifiable, Hashable, Codable {
    public let id: String
    public var senderId: String
    public var text: String
    public var timestamp: String
    public var isFromCurrentUser: Bool
    
    public init(
        id: String = UUID().uuidString,
        senderId: String,
        text: String,
        timestamp: String,
        isFromCurrentUser: Bool
    ) {
        self.id = id
        self.senderId = senderId
        self.text = text
        self.timestamp = timestamp
        self.isFromCurrentUser = isFromCurrentUser
    }
}

public struct Conversation: Identifiable, Hashable, Codable {
    public let id: String
    public var participantName: String
    public var participantRole: String
    public var participantClub: String?
    public var isVerified: Bool
    public var lastMessage: String
    public var timeAgo: String
    public var unreadCount: Int
    
    public init(
        id: String = UUID().uuidString,
        participantName: String,
        participantRole: String = "Joueur",
        participantClub: String? = nil,
        isVerified: Bool = false,
        lastMessage: String,
        timeAgo: String,
        unreadCount: Int = 0
    ) {
        self.id = id
        self.participantName = participantName
        self.participantRole = participantRole
        self.participantClub = participantClub
        self.isVerified = isVerified
        self.lastMessage = lastMessage
        self.timeAgo = timeAgo
        self.unreadCount = unreadCount
    }
}
