import Foundation
import Observation

public enum DiscoverCategory: String, CaseIterable {
    case all = "Tous"
    case players = "Joueurs"
    case clubs = "Clubs"
}

@Observable
public final class DiscoverViewModel {
    private let dataService: MockDataService
    
    public var searchQuery: String = ""
    public var selectedCategory: DiscoverCategory = .all
    public var selectedPosition: BasketballPosition? = nil
    public var selectedCity: String? = nil
    public var availableOnly: Bool = false
    
    public let availableCities = ["Toutes", "Dakar", "Thiès", "Pikine", "Saint-Louis", "Ziguinchor"]
    
    public init(dataService: MockDataService = .shared) {
        self.dataService = dataService
    }
    
    public var filteredPlayers: [Player] {
        dataService.searchPlayers(
            query: searchQuery,
            position: selectedPosition,
            city: selectedCity == "Toutes" ? nil : selectedCity,
            availableOnly: availableOnly
        )
    }
    
    public var filteredClubs: [Club] {
        dataService.searchClubs(query: searchQuery)
    }
}
