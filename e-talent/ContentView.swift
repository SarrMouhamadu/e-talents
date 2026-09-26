import SwiftUI

/// Vue racine de prévisualisation et passerelle vers MainTabView
public struct ContentView: View {
    public init() {}
    
    public var body: some View {
        MainTabView()
            .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
