import Foundation
import Observation

@Observable
public final class HomeViewModel {
    private let dataService: MockDataService
    
    public var selectedPostForComments: Post?
    public var selectedAuthorId: String?
    public var showNotifications: Bool = false
    public var errorMessage: String? = nil
    
    public init(dataService: MockDataService = .shared) {
        self.dataService = dataService
    }
    
    public var posts: [Post] {
        dataService.posts
    }
    
    public var isLoading: Bool {
        dataService.isLoadingFeed
    }
    
    public func loadFeed() async {
        errorMessage = nil
        await dataService.fetchFeed()
    }
    
    public func toggleLike(postId: String) {
        dataService.toggleLike(for: postId)
    }
    
    public func toggleBookmark(postId: String) {
        dataService.toggleBookmark(for: postId)
    }
}
