import SwiftUI
import SwiftData

struct TrackerScreen: View {
    @ObservedObject var state: BabyAppState
    @Query(sort: \LogEntry.timestamp, order: .reverse) private var logs: [LogEntry]
    @State private var showingManualEntry = false
    @State private var selectedEvent: EventType = .nursing
    @State private var selectedTab = "Logs"
    
    var body: some View {
        VStack(spacing: 0) {
            if selectedTab == "Logs" {
                VStack(spacing: 0) {
                    TrackerHeaderView(state: state)
                    
                    ZStack(alignment: .bottomTrailing) {
                        TrackerTimelineView(logs: logs)
                        
                        HStack(spacing: 16) {
                            FloatingButton(icon: "magnifyingglass") {}
                            FloatingButton(icon: "stopwatch") {}
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                    
                    Divider().background(Color.appAccent).frame(height: 2)
                    
                    EventRibbonView(onLog: { event in
                        selectedEvent = event
                        showingManualEntry = true
                    })
                }
            } else if selectedTab == "Summary" {
                PlaceholderView(title: "Summary")
            } else if selectedTab == "Growth Chart" {
                PlaceholderView(title: "Growth Chart")
            } else if selectedTab == "Menu" {
                MenuView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            Divider().background(Color.gray.opacity(0.3))
            
            BottomTabBarView(selectedTab: $selectedTab)
        }
        .background(Color.appBackground)
        .sheet(isPresented: $showingManualEntry) {
            ManualEntryForm(babyID: UUID(), defaultType: selectedEvent)
        }
    }
}

struct PlaceholderView: View {
    let title: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(Font.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Text("Coming Soon")
                .font(Font.system(size: 16))
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
    }
}

struct TrackerHeaderView: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack(spacing: 8) {
            // Top Status Area
            HStack {
                Spacer()
                HStack(spacing: 4) {
                    Text("👶").font(Font.system(size: 14))
                    Text("0 mo 5 d").font(Font.system(size: 14, weight: .bold)).foregroundColor(Color.white)
                }
                Spacer()
                
                Button(action: {}) {
                    Text("Upgrade")
                        .font(Font.system(size: 12, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            // Date Navigation
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: 24, weight: .bold))
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                Text("Mon, Apr 13, 2026")
                    .font(Font.system(size: 22, weight: .bold))
                    .foregroundColor(Color.appAccent)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .font(Font.system(size: 24, weight: .bold))
                        .foregroundColor(Color.white)
                }
            }
            .padding(.horizontal, 16)
            
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    Text("Day 5").font(Font.system(size: 14, weight: .bold)).foregroundColor(Color.white)
                    Text("after birth").font(Font.system(size: 10)).foregroundColor(Color.appTextSecondary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            Divider().background(Color.gray.opacity(0.3))
        }
        .background(Color.appBackground)
    }
}

struct TrackerTimelineView: View {
    let logs: [LogEntry]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Initial Top Row / Stats
                HStack(spacing: 12) {
                    ZStack {
                        Image(systemName: "star.fill")
                            .font(Font.system(size: 24))
                            .foregroundColor(Color.purple.opacity(0.6))
                        Text("👶").font(Font.system(size: 14))
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("4h").font(Font.system(size: 14, weight: .bold)).foregroundColor(Color.white)
                        Text("56m").font(Font.system(size: 12)).foregroundColor(Color.white)
                    }
                    Spacer()
                }
                .padding(.horizontal, 60)
                .padding(.vertical, 12)
                .background(Color.appBackground)
                
                Divider().background(Color.gray.opacity(0.3))
                
                // Timeline Rows
                ForEach(0..<24) { hour in
                    let hourLogs = logs.filter { Calendar.current.component(.hour, from: $0.timestamp) == hour }
                    
                    HStack(spacing: 0) {
                        // Time Sidebar
                        ZStack(alignment: .top) {
                            Color.timelineSidebar
                            
                            Text("\(hour)")
                                .font(Font.system(size: 14, weight: .bold))
                                .foregroundColor(Color.white)
                                .padding(.top, 12)
                        }
                        .frame(width: 48)
                        
                        Divider().background(Color.gray.opacity(0.3))
                        
                        // Content Area
                        VStack(alignment: .leading, spacing: 5) {
                            if hourLogs.isEmpty {
                                Color.clear.frame(height: 44)
                            } else {
                                ForEach(hourLogs) { entry in
                                    TimelineRow(entry: entry)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Divider().background(Color.gray.opacity(0.3))
                }
            }
        }
    }
}

// MARK: - Event Ribbon
struct EventIcon: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let shapeColor: Color
    let shapeType: Int // 0: Circle, 1: Triangle, 2: Diamond, 3: Square
}

struct EventRibbonView: View {
    var onLog: (EventType) -> Void
    
    let events: [(EventType, String, Color, Int)] = [
        (.bottle, "🍼", .teal, 3),
        (.ebm, "🥛", .yellow, 0),
        (.nursing, "🤱", .pink, 1),
        (.wetDiaper, "💧", .blue, 0),
        (.dirtyDiaper, "💩", .orange, 0),
        (.bodyTemp, "🌡️", .pink, 1),
        (.height, "📏", .blue, 1),
        (.weight, "⚖️", .green, 1),
        (.headSize, "👤", .purple, 1),
        (.chestSize, "👕", .orange, 1),
        (.solidFood, "🥣", .yellow, 0),
        (.snack, "🍪", .brown, 0),
        (.meal, "🍱", .cyan, 0),
        (.drink, "🧃", .blue, 0),
        (.sleep, "💤", .purple, 0),
        (.vaccination, "💉", .mint, 3),
        (.walk, "🚶", .green, 2),
        (.milestone, "🚩", .red, 2),
        (.medicine, "💊", .blue, 3),
        (.bath, "🛀", .cyan, 0),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(events, id: \.0) { event, emoji, color, shapeType in
                    Button(action: { onLog(event) }) {
                        VStack(spacing: 6) {
                            ZStack {
                                if shapeType == 0 {
                                    Circle().fill(color.opacity(0.3)).frame(width: 44, height: 44)
                                    Circle().stroke(color, lineWidth: 2).frame(width: 44, height: 44)
                                } else if shapeType == 1 {
                                    Image(systemName: "triangle.fill").font(Font.system(size: 40)).foregroundColor(color.opacity(0.3))
                                    Image(systemName: "triangle").font(Font.system(size: 40)).foregroundColor(color)
                                } else if shapeType == 2 {
                                    Rectangle().fill(color.opacity(0.3)).frame(width: 36, height: 36).rotationEffect(.degrees(45))
                                    Rectangle().stroke(color, lineWidth: 2).frame(width: 36, height: 36).rotationEffect(.degrees(45))
                                } else {
                                    RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.3)).frame(width: 40, height: 40)
                                    RoundedRectangle(cornerRadius: 8).stroke(color, lineWidth: 2).frame(width: 40, height: 40)
                                }
                                
                                Text(emoji).font(Font.system(size: 24))
                            }
                            .frame(height: 50)
                            
                            Text(event.rawValue.capitalized)
                                .font(Font.system(size: 11, weight: .bold))
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color.timelineSidebar)
    }
}

// MARK: - Floating Buttons & Tab Bar
struct FloatingButton: View {
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.appAccent)
                    .frame(width: 65, height: 65)
                
                Image(systemName: icon)
                    .font(Font.system(size: 30, weight: .bold))
                    .foregroundColor(Color.timelineSidebar)
            }
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
        }
    }
}

struct BottomTabBarView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            TabBarItem(icon: "pencil", title: "Logs", isSelected: selectedTab == "Logs") { selectedTab = "Logs" }
            TabBarItem(icon: "chart.bar.fill", title: "Summary", isSelected: selectedTab == "Summary") { selectedTab = "Summary" }
            TabBarItem(icon: "chart.xyaxis.line", title: "Growth Chart", isSelected: selectedTab == "Growth Chart") { selectedTab = "Growth Chart" }
            TabBarItem(icon: "line.3.horizontal", title: "Menu", isSelected: selectedTab == "Menu") { selectedTab = "Menu" }
        }
        .padding(.top, 12)
        .padding(.bottom, 30)
        .background(Color.appDarkGray)
    }
}

struct TabBarItem: View {
    var icon: String
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Spacer()
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(Font.system(size: 24, weight: isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? Color.appAccent : Color.gray)
                
                Text(title)
                    .font(Font.system(size: 10, weight: isSelected ? .bold : .medium))
                    .foregroundColor(isSelected ? Color.appAccent : Color.gray)
            }
        }
        Spacer()
    }
}
