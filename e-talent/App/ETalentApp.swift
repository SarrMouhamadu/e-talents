import SwiftUI

@main
struct ETalentApp: App {
    @State private var showSplash: Bool = true
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var onboardingStep: OnboardingStep = .welcome
    
    enum OnboardingStep {
        case welcome
        case accountType
        case createPlayerProfile
        case createClubProfile
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                if showSplash {
                    SplashView(showSplash: $showSplash)
                } else if !hasCompletedOnboarding {
                    NavigationStack {
                        switch onboardingStep {
                        case .welcome:
                            WelcomeView(
                                onStart: { onboardingStep = .accountType },
                                onSkip: { hasCompletedOnboarding = true }
                            )
                        case .accountType:
                            AccountTypeView { type in
                                switch type {
                                case .player:
                                    onboardingStep = .createPlayerProfile
                                case .club:
                                    onboardingStep = .createClubProfile
                                }
                            }
                        case .createPlayerProfile:
                            PlayerProfileCreationView {
                                withAnimation {
                                    hasCompletedOnboarding = true
                                }
                            }
                        case .createClubProfile:
                            ClubProfileCreationView {
                                withAnimation {
                                    hasCompletedOnboarding = true
                                }
                            }
                        }
                    }
                } else {
                    MainTabView()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
