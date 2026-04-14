import SwiftUI
import SwiftData

struct TrackerScreen: View {
    @ObservedObject var state: BabyAppState
    @Query(sort: \LogEntry.timestamp, order: .reverse) private var logs: [LogEntry]
    @State private var showingManualEntry = false
    @State private var selectedEvent: EventType = .nursing
    
    var body: some View {
        VStack(spacing: 0) {
            TrackerHeaderView(state: state)
            
            ZStack(alignment: .bottomTrailing) {
                TrackerTimelineView(logs: logs)
                
                HStack(spacing: 16) {
                    FloatingButton(icon: "magnifyingglass")
                    FloatingButton(icon: "stopwatch")
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            
            Divider().background(Color.appAccent).frame(height: 2)
            
            EventRibbonView(onLog: { event in
                selectedEvent = event
                showingManualEntry = true
            })
            
            Divider().background(Color.gray.opacity(0.3))
        }
        .background(Color.appBackground)
        .sheet(isPresented: $showingManualEntry) {
            ManualEntryForm(babyID: UUID(), defaultType: selectedEvent)
        }
    }
}

// ... TrackerHeaderView, TrackerTimelineView, FloatingButton, EventRibbonView remain unchanged

struct TrackerHeaderView: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                HStack(spacing: 4) {
                    Text("👶").font(.system(size: 14))
                    Text(state.nickname.isEmpty ? "No name" : state.nickname).font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                }
                Spacer()
                
                Button(action: {}) {
                    Text("Upgrade")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            HStack {
                Button(action: {}) { Image(systemName: "chevron.left").font(.system(size: 24, weight: .bold)).foregroundColor(.white) }
                Spacer()
                Text("Mon, Apr 13, 2026")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.appAccent)
                Spacer()
                Button(action: {}) { Image(systemName: "chevron.right").font(.system(size: 24, weight: .bold)).foregroundColor(.white) }
            }
            .padding(.horizontal, 16)
            
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
                ForEach(0..<24, id: \.self) { hour in
                    let hourLogs = logs.filter { Calendar.current.component(.hour, from: $0.timestamp) == hour }
                    
                    HStack(spacing: 0) {
                        ZStack(alignment: .top) {
                            Color.timelineSidebar
                            Text("\(hour):00")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.top, 8)
                        }
                        .frame(width: 50)
                        
                        Divider().background(Color.gray.opacity(0.3))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            if hourLogs.isEmpty {
                                Color.clear.frame(height: 50)
                            } else {
                                ForEach(hourLogs) { entry in
                                    TimelineRow(entry: entry)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 5)
                    }
                    Divider().background(Color.gray.opacity(0.3))
                }
            }
        }
    }
}

struct FloatingButton: View {
    var icon: String
    
    var body: some View {
        ZStack {
            Circle().fill(Color.appAccent).frame(width: 50, height: 50)
            Image(systemName: icon).foregroundColor(.white).font(.system(size: 20))
        }
    }
}

struct EventRibbonView: View {
    var onLog: (EventType) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(EventType.allCases, id: \.self) { event in
                    Button(action: { onLog(event) }) {
                        VStack(spacing: 6) {
                            LogEventIcon(eventType: event)
                            Text(event.rawValue.capitalized)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color.appDarkGray)
    }
}

struct BottomTabBarView: View {
    var body: some View {
        HStack {
            TabBarItem(icon: "pencil", title: "Logs", isSelected: true)
            TabBarItem(icon: "chart.bar.fill", title: "Summary", isSelected: false)
            TabBarItem(icon: "chart.xyaxis.line", title: "Growth", isSelected: false)
            TabBarItem(icon: "line.3.horizontal", title: "Menu", isSelected: false)
        }
        .padding(.vertical, 10)
        .background(Color.appDarkGray)
    }
}

struct TabBarItem: View {
    var icon: String
    var title: String
    var isSelected: Bool
    
    var body: some View {
        Spacer()
        VStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 20))
            Text(title).font(.system(size: 10))
        }
        .foregroundColor(isSelected ? .appAccent : .appTextSecondary)
        Spacer()
    }
}

