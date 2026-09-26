import SwiftUI

public struct DiscoverView: View {
    @State private var viewModel = DiscoverViewModel()
    @State private var selectedPlayer: Player?
    @State private var selectedClub: Club?
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                VStack(spacing: ETSpacing.small) {
                    // MARK: - Subtitle
                    VStack(alignment: .leading, spacing: ETSpacing.xxSmall) {
                        Text("Découvre les talents et clubs du basketball sénégalais.")
                            .font(ETTypography.callout)
                            .foregroundColor(ETColors.secondaryText)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.top, ETSpacing.xxSmall)
                    
                    // MARK: - Search Bar
                    ETSearchBar(
                        text: $viewModel.searchQuery,
                        placeholder: "Rechercher un joueur ou un club"
                    )
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.top, ETSpacing.xSmall)
                    
                    // MARK: - Category Filters
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: ETSpacing.small) {
                            ForEach(DiscoverCategory.allCases, id: \.self) { category in
                                ETFilterChip(
                                    category.rawValue,
                                    isSelected: viewModel.selectedCategory == category,
                                    action: {
                                        viewModel.selectedCategory = category
                                    }
                                )
                            }
                            
                            // Filtre Disponibilité
                            ETFilterChip(
                                "Disponibles",
                                icon: "checkmark.circle",
                                isSelected: viewModel.availableOnly,
                                action: {
                                    viewModel.availableOnly.toggle()
                                }
                            )
                        }
                        .padding(.horizontal, ETSpacing.standard)
                    }
                    
                    // MARK: - Positions Filters (si Tous ou Joueurs)
                    if viewModel.selectedCategory != .clubs {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: ETSpacing.small) {
                                ETFilterChip(
                                    "Tous postes",
                                    isSelected: viewModel.selectedPosition == nil,
                                    action: { viewModel.selectedPosition = nil }
                                )
                                
                                ForEach(BasketballPosition.allCases) { pos in
                                    ETFilterChip(
                                        "\(pos.shortCode) - \(pos.rawValue)",
                                        isSelected: viewModel.selectedPosition == pos,
                                        action: { viewModel.selectedPosition = pos }
                                    )
                                }
                            }
                            .padding(.horizontal, ETSpacing.standard)
                        }
                    }
                    
                    // MARK: - Results List
                    ScrollView {
                        LazyVStack(spacing: ETSpacing.small) {
                            // Section Joueurs
                            if viewModel.selectedCategory != .clubs {
                                if !viewModel.filteredPlayers.isEmpty {
                                    ForEach(viewModel.filteredPlayers) { player in
                                        ETPlayerCard(player: player) {
                                            selectedPlayer = player
                                        }
                                        .padding(.horizontal, ETSpacing.standard)
                                    }
                                }
                            }
                            
                            // Section Clubs
                            if viewModel.selectedCategory != .players {
                                if !viewModel.filteredClubs.isEmpty {
                                    ForEach(viewModel.filteredClubs) { club in
                                        ETClubCard(club: club) {
                                            selectedClub = club
                                        }
                                        .padding(.horizontal, ETSpacing.standard)
                                    }
                                }
                            }
                            
                            // Empty State
                            if (viewModel.selectedCategory == .players && viewModel.filteredPlayers.isEmpty) ||
                                (viewModel.selectedCategory == .clubs && viewModel.filteredClubs.isEmpty) ||
                                (viewModel.selectedCategory == .all && viewModel.filteredPlayers.isEmpty && viewModel.filteredClubs.isEmpty) {
                                ETEmptyState(
                                    icon: "magnifyingglass",
                                    title: "Aucun résultat",
                                    description: "Essaie avec un autre nom, une autre ville ou une autre position."
                                )
                                .padding(.top, ETSpacing.large)
                            }
                        }
                        .padding(.vertical, ETSpacing.small)
                    }
                }
            }
            .navigationTitle("Découvrir")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedPlayer) { player in
                NavigationStack {
                    PlayerProfileView(player: player)
                }
            }
            .sheet(item: $selectedClub) { club in
                NavigationStack {
                    ClubProfileView(club: club)
                }
            }
        }
    }
}
