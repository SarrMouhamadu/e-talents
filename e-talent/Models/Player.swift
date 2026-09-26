import Foundation

public enum BasketballPosition: String, CaseIterable, Identifiable, Codable {
    case pointGuard = "Meneur"
    case shootingGuard = "Arrière"
    case smallForward = "Ailier"
    case powerForward = "Ailier fort"
    case center = "Pivot"
    
    public var id: String { rawValue }
    
    public var shortCode: String {
        switch self {
        case .pointGuard: return "PG"
        case .shootingGuard: return "SG"
        case .smallForward: return "SF"
        case .powerForward: return "PF"
        case .center: return "C"
        }
    }
}

public struct Player: Identifiable, Hashable, Codable {
    public let id: String
    public var name: String
    public var position: BasketballPosition
    public var age: Int
    public var heightCm: Int
    public var city: String
    public var clubName: String?
    public var isAvailable: Bool
    public var isVerified: Bool
    public var bio: String
    public var avatarUrl: String?
    public var photosCount: Int
    public var videosCount: Int
    public var followersCount: Int
    public var followingCount: Int
    
    public var formattedHeight: String {
        "\(heightCm) cm"
    }
    
    public var clubOrStatus: String {
        if let club = clubName, !club.isEmpty {
            return club
        }
        return isAvailable ? "Disponible" : "Sans club"
    }
    
    public init(
        id: String = UUID().uuidString,
        name: String,
        position: BasketballPosition,
        age: Int,
        heightCm: Int,
        city: String,
        clubName: String? = nil,
        isAvailable: Bool = true,
        isVerified: Bool = false,
        bio: String,
        avatarUrl: String? = nil,
        photosCount: Int = 0,
        videosCount: Int = 0,
        followersCount: Int = 0,
        followingCount: Int = 0
    ) {
        self.id = id
        self.name = name
        self.position = position
        self.age = age
        self.heightCm = heightCm
        self.city = city
        self.clubName = clubName
        self.isAvailable = isAvailable
        self.isVerified = isVerified
        self.bio = bio
        self.avatarUrl = avatarUrl
        self.photosCount = photosCount
        self.videosCount = videosCount
        self.followersCount = followersCount
        self.followingCount = followingCount
    }
}
