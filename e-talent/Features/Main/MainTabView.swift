import SwiftUI

public enum MainTab: Int, CaseIterable {
    case home = 0
    case discover = 1
    case create = 2
    case messages = 3
    case profile = 4
}

public struct MainTabView: View {
    @State private var selectedTab: MainTab = .home
    @State private var previousTab: MainTab = .home
    @State private var showCreatePost: Bool = false
    
    public init() {
        // Personnalisation de l'apparence de la UITabBar native
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(ETColors.background)
        
        // Items inactifs
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(ETColors.secondaryText)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(ETColors.secondaryText),
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        
        // Items actifs
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(ETColors.primaryOrange)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(ETColors.primaryOrange),
            .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    public var body: some View {
        TabView(selection: Binding(
            get: { selectedTab },
            set: { newTab in
                if newTab == .create {
                    showCreatePost = true
                } else {
                    selectedTab = newTab
                    previousTab = newTab
                }
            }
        )) {
            // MARK: - 1. Accueil
            HomeView()
                .tabItem {
                    Label("Accueil", systemImage: selectedTab == .home ? "house.fill" : "house")
                }
                .tag(MainTab.home)
            
            // MARK: - 2. Découvrir
            DiscoverView()
                .tabItem {
                    Label("Découvrir", systemImage: "magnifyingglass")
                }
                .tag(MainTab.discover)
            
            // MARK: - 3. Publier
            Color.clear
                .tabItem {
                    Label("Publier", systemImage: "plus.circle.fill")
                }
                .tag(MainTab.create)
            
            // MARK: - 4. Messages
            MessagesView()
                .tabItem {
                    Label("Messages", systemImage: selectedTab == .messages ? "bubble.left.and.bubble.right.fill" : "bubble.left.and.bubble.right")
                }
                .tag(MainTab.messages)
            
            // MARK: - 5. Profil
            MyProfileView()
                .tabItem {
                    Label("Profil", systemImage: selectedTab == .profile ? "person.crop.circle.fill" : "person.crop.circle")
                }
                .tag(MainTab.profile)
        }
        .tint(ETColors.primaryOrange)
        .sheet(isPresented: $showCreatePost) {
            CreatePostView()
        }
    }
}
