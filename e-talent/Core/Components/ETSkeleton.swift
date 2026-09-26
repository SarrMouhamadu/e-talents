import SwiftUI

public struct ETSkeletonView: View {
    @State private var isAnimating: Bool = false
    private let height: CGFloat?
    private let cornerRadius: CGFloat
    
    public init(height: CGFloat? = nil, cornerRadius: CGFloat = 8) {
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(ETColors.darkSurface)
            .opacity(isAnimating ? 0.35 : 0.75)
            .frame(height: height)
            .onAppear {
                withAnimation(
                    Animation.easeInOut(duration: 0.9)
                        .repeatForever(autoreverses: true)
                ) {
                    isAnimating = true
                }
            }
    }
}

public struct ETPostCardSkeleton: View {
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: ETSpacing.small) {
            HStack(spacing: ETSpacing.small) {
                ETSkeletonView(height: 36, cornerRadius: 18)
                    .frame(width: 36)
                
                VStack(alignment: .leading, spacing: 6) {
                    ETSkeletonView(height: 14, cornerRadius: 4)
                        .frame(width: 120)
                    ETSkeletonView(height: 10, cornerRadius: 4)
                        .frame(width: 80)
                }
                Spacer()
            }
            
            ETSkeletonView(height: 16, cornerRadius: 4)
            ETSkeletonView(height: 16, cornerRadius: 4)
                .frame(width: 240)
            
            ETSkeletonView(height: 220, cornerRadius: ETRadius.media)
            
            HStack(spacing: ETSpacing.large) {
                ETSkeletonView(height: 20, cornerRadius: 4)
                    .frame(width: 50)
                ETSkeletonView(height: 20, cornerRadius: 4)
                    .frame(width: 50)
                Spacer()
            }
        }
        .padding(ETSpacing.standard)
        .background(ETColors.darkSurface.opacity(0.6))
        .cornerRadius(ETRadius.card)
    }
}

public struct ETPlayerCardSkeleton: View {
    public init() {}
    
    public var body: some View {
        HStack(spacing: ETSpacing.standard) {
            ETSkeletonView(height: 48, cornerRadius: 24)
                .frame(width: 48)
            
            VStack(alignment: .leading, spacing: 8) {
                ETSkeletonView(height: 14, cornerRadius: 4)
                    .frame(width: 140)
                ETSkeletonView(height: 11, cornerRadius: 4)
                    .frame(width: 100)
                ETSkeletonView(height: 10, cornerRadius: 4)
                    .frame(width: 70)
            }
            Spacer()
        }
        .padding(ETSpacing.standard)
        .background(ETColors.darkSurface.opacity(0.6))
        .cornerRadius(ETRadius.card)
    }
}
