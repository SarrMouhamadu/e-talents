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
                
                // Logo & Basket Icon
                ZStack {
                    Circle()
                        .fill(ETColors.primaryOrange.opacity(0.12))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "basketball.fill")
                        .font(.system(size: 64))
                        .foregroundColor(ETColors.primaryOrange)
                }
                
                VStack(spacing: ETSpacing.xSmall) {
                    Text("E-TALENT")
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .foregroundColor(ETColors.pureWhite)
                        .tracking(2)
                    
                    Text("BASKETBALL SÉNÉGAL")
                        .font(ETTypography.badge)
                        .fontWeight(.bold)
                        .foregroundColor(ETColors.primaryOrange)
                        .tracking(3)
                }
                
                // Drapeau discret Sénégal
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 2).fill(ETColors.senegalGreen).frame(width: 14, height: 4)
                    RoundedRectangle(cornerRadius: 2).fill(ETColors.senegalYellow).frame(width: 14, height: 4)
                    RoundedRectangle(cornerRadius: 2).fill(ETColors.senegalRed).frame(width: 14, height: 4)
                }
                
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
