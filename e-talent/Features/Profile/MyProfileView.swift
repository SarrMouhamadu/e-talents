import SwiftUI

public struct MyProfileView: View {
    @State private var currentPlayer: Player = MockData.samplePlayers[1] // Mamadou Sarr
    @State private var showSettings: Bool = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                // Vue profil unifiée sans duplication d'en-tête ni de ScrollView
                PlayerProfileView(player: currentPlayer, isCurrentUser: true)
            }
            .navigationTitle("Mon Profil")
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
