import SwiftUI
import SwiftUI
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TrackerScreen(state: BabyAppState())
                .tabItem { Label("Logs", systemImage: "pencil.line") }
            
            PlaceholderView(title: "Summary")
                .tabItem { Label("Summary", systemImage: "chart.bar.xaxis") }
                
            PlaceholderView(title: "Growth Chart")
                .tabItem { Label("Growth Chart", systemImage: "chart.line.uptrend.xyaxis") }
                
            MenuView()
                .tabItem { Label("Menu", systemImage: "line.3.horizontal") }
        }
        .accentColor(Color.appAccent)
    }
}

struct PlaceholderView: View {
    let title: String
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Coming Soon")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
}
