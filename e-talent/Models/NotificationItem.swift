import Foundation

public enum NotificationType: String, Codable {
    case like
    case comment
    case follow
    case message
    case scout
}

public struct NotificationItem: Identifiable, Hashable, Codable {
    public let id: String
    public var type: NotificationType
    public var actorName: String
    public var actorRole: String?
    public var actionDescription: String
    public var timeAgo: String
    public var isRead: Bool
    
    public init(
        id: String = UUID().uuidString,
        type: NotificationType,
        actorName: String,
        actorRole: String? = nil,
        actionDescription: String,
        timeAgo: String,
        isRead: Bool = false
    ) {
        self.id = id
        self.type = type
        self.actorName = actorName
        self.actorRole = actorRole
        self.actionDescription = actionDescription
        self.timeAgo = timeAgo
        self.isRead = isRead
    }
}
