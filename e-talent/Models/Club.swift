import Foundation

public struct Club: Identifiable, Hashable, Codable {
    public let id: String
    public var name: String
    public var city: String
    public var division: String
    public var isVerified: Bool
    public var description: String
    public var playersCount: Int
    public var logoUrl: String?
    public var bannerUrl: String?
    public var followersCount: Int
    public var representativeName: String?
    public var representativeRole: String?
    public var logoData: Data?
    
    public init(
        id: String = UUID().uuidString,
        name: String,
        city: String,
        division: String = "National 1",
        isVerified: Bool = false,
        description: String,
        playersCount: Int = 0,
        logoUrl: String? = nil,
        bannerUrl: String? = nil,
        followersCount: Int = 0,
        representativeName: String? = nil,
        representativeRole: String? = nil,
        logoData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.city = city
        self.division = division
        self.isVerified = isVerified
        self.description = description
        self.playersCount = playersCount
        self.logoUrl = logoUrl
        self.bannerUrl = bannerUrl
        self.followersCount = followersCount
        self.representativeName = representativeName
        self.representativeRole = representativeRole
        self.logoData = logoData
    }
}
