import SwiftUI

struct SpectatorHomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // 1. SEKME
            FixtureView()
                .tabItem { Label("Fikstür", systemImage: "calendar") }
                .tag(0)
            
            // 2. SEKME
            GroupsView()
                .tabItem { Label("Gruplar", systemImage: "list.bullet.rectangle.portrait") }
                .tag(1)
            
            // 3. SEKME (YENİ)
            KnockoutView()
                .tabItem { Label("Elemeler", systemImage: "trophy.fill") }
                .tag(2)
            
            // 4. SEKME
            StatsView()
                .tabItem { Label("İstatistikler", systemImage: "chart.bar.fill") }
                .tag(3)
            
            
        }
        .tint(.cyan)
        // WelcomeScreen'den gelen ana barı gizleme kodumuz (çakışmaları önlemek için kalıyor)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
#Preview {
    SpectatorHomeView()
}
