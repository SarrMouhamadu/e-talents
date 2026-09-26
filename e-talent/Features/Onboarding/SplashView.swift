import SwiftUI

public struct SplashView: View {
    @Binding var showSplash: Bool
    @State private var scale: CGFloat = 0.85
    @State private var opacity: Double = 0.0
    
    public init(showSplash: Binding<Bool>) {
        self._showSplash = showSplash
    }
    
    public var body: some View {
        ZStack {
            ETColors.pureBlack.ignoresSafeArea()
            
            VStack(spacing: ETSpacing.large) {
                Spacer()
                
                // Logo officiel E-TALENT
                Image("ETalentLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 240, maxHeight: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                    .shadow(color: ETColors.primaryOrange.opacity(0.25), radius: 24, x: 0, y: 10)
                    .accessibilityLabel("Logo officiel E-Talent")
                
                Spacer()
                
                Text("Crée ton profil. Montre ton talent. Fais-toi découvrir.")
                    .font(ETTypography.callout)
                    .foregroundColor(ETColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, ETSpacing.large)
                    .padding(.bottom, ETSpacing.large)
            }
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                scale = 1.0
                opacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeOut(duration: 0.4)) {
                    showSplash = false
                }
            }
        }
    }
}
