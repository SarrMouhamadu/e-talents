import SwiftUI

public struct MyProfileView: View {
    @AppStorage("userAccountType") private var userAccountType: String = "player"
    @State private var currentPlayer: Player = MockData.samplePlayers[1] // Mamadou Sarr
    @State private var showSettings: Bool = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                if userAccountType == "club", let currentClub = MockDataService.shared.currentClub {
                    ClubProfileView(club: currentClub, isCurrentClub: true)
                } else {
                    PlayerProfileView(player: currentPlayer, isCurrentUser: true)
                }
            }
            .navigationTitle(userAccountType == "club" ? "Profil du Club" : "Mon Profil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(ETColors.pureWhite)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .accessibilityLabel("Paramètres du compte")
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(player: $currentPlayer)
            }
        }
    }
}
