import SwiftUI

public struct SettingsView: View {
    @Binding var player: Player
    @Environment(\.dismiss) private var dismiss
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = true
    @AppStorage("userAccountType") private var userAccountType: String = "player"
    
    @State private var showEditProfile: Bool = false
    @State private var showLogoutConfirmation: Bool = false
    @State private var notificationsEnabled: Bool = true
    @State private var profileVisitsEnabled: Bool = true
    
    public init(player: Binding<Player>) {
        self._player = player
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                List {
                    // MARK: - Section Compte
                    Section(header: Text("COMPTE").font(ETTypography.caption).foregroundColor(ETColors.secondaryText)) {
                        if userAccountType == "player" {
                            Button(action: { showEditProfile = true }) {
                                HStack {
                                    Label("Modifier mon profil", systemImage: "person.crop.circle")
                                        .foregroundColor(ETColors.pureWhite)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(ETColors.secondaryText)
                                }
                                .frame(minHeight: 44)
                            }
                        }
                        
                        HStack {
                            Label("Statut du compte", systemImage: userAccountType == "club" ? "shield.checkered" : "figure.basketball")
                                .foregroundColor(ETColors.pureWhite)
                            Spacer()
                            Text(userAccountType == "club" ? "Club vérifié" : "Joueur vérifié")
                                .font(ETTypography.caption)
                                .foregroundColor(ETColors.primaryOrange)
                        }
                        .frame(minHeight: 44)
                    }
                    .listRowBackground(ETColors.darkSurface)
                    .listRowSeparatorTint(ETColors.borderGray.opacity(0.12))
                    
                    // MARK: - Section Notifications
                    Section(header: Text("NOTIFICATIONS").font(ETTypography.caption).foregroundColor(ETColors.secondaryText)) {
                        Toggle(isOn: $notificationsEnabled) {
                            Label("Messages et alertes", systemImage: "bell.badge")
                                .foregroundColor(ETColors.pureWhite)
                        }
                        .tint(ETColors.primaryOrange)
                        .frame(minHeight: 44)
                        
                        Toggle(isOn: $profileVisitsEnabled) {
                            Label("Visites de profil par les clubs", systemImage: "eye")
                                .foregroundColor(ETColors.pureWhite)
                        }
                        .tint(ETColors.primaryOrange)
                        .frame(minHeight: 44)
                    }
                    .listRowBackground(ETColors.darkSurface)
                    .listRowSeparatorTint(ETColors.borderGray.opacity(0.12))
                    
                    // MARK: - Section Application
                    Section(header: Text("À PROPOS").font(ETTypography.caption).foregroundColor(ETColors.secondaryText)) {
                        HStack {
                            Text("Version")
                                .foregroundColor(ETColors.pureWhite)
                            Spacer()
                            Text("1.0.0 (V1 Sénégal)")
                                .font(ETTypography.caption)
                                .foregroundColor(ETColors.secondaryText)
                        }
                        .frame(minHeight: 44)
                        
                        HStack {
                            Text("Plateforme")
                                .foregroundColor(ETColors.pureWhite)
                            Spacer()
                            Text("E-Talent Basketball")
                                .font(ETTypography.caption)
                                .foregroundColor(ETColors.primaryOrange)
                        }
                        .frame(minHeight: 44)
                    }
                    .listRowBackground(ETColors.darkSurface)
                    .listRowSeparatorTint(ETColors.borderGray.opacity(0.12))
                    
                    // MARK: - Section Déconnexion (Point 7)
                    Section {
                        Button(action: { showLogoutConfirmation = true }) {
                            HStack {
                                Spacer()
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Se déconnecter")
                                    .font(ETTypography.button)
                                Spacer()
                            }
                            .foregroundColor(ETColors.error)
                            .frame(minHeight: 44)
                        }
                    }
                    .listRowBackground(ETColors.darkSurface)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Paramètres")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fermer") {
                        dismiss()
                    }
                    .font(ETTypography.button)
                    .foregroundColor(ETColors.primaryOrange)
                    .frame(minWidth: 44, minHeight: 44)
                    .contentShape(Rectangle())
                }
            }
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(player: $player)
            }
            .alert("Déconnexion", isPresented: $showLogoutConfirmation) {
                Button("Annuler", role: .cancel) {}
                Button("Se déconnecter", role: .destructive) {
                    performLogout()
                }
            } message: {
                Text("Êtes-vous sûr de vouloir vous déconnecter d'E-Talent ? Vous pourrez vous reconnecter à tout moment.")
            }
        }
    }
    
    private func performLogout() {
        dismiss()
        withAnimation(.easeInOut(duration: 0.3)) {
            hasCompletedOnboarding = false
            userAccountType = "player"
        }
    }
}
