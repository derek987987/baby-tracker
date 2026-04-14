import SwiftUI
import SwiftData
import Combine

// MARK: - App State
class BabyAppState: ObservableObject {
    @Published var currentStep: AppStep = .landing
    @Published var nickname: String = ""
    @Published var gender: Gender = .notSet
    @Published var dob: Date? = nil
    
    // Animation direction tracker
    @Published var isMovingForward = true
    
    func nextStep() {
        isMovingForward = true
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = AppStep(rawValue: currentStep.rawValue + 1) ?? .tracker
        }
    }
    
    func prevStep() {
        isMovingForward = false
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = AppStep(rawValue: currentStep.rawValue - 1) ?? .landing
        }
    }
    
    func reset() {
        isMovingForward = false
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = .landing
            nickname = ""
            gender = .notSet
            dob = nil
        }
    }
}

// MARK: - App Step
enum AppStep: Int {
    case landing = 0
    case intro = 1
    case nickname = 2
    case gender = 3
    case dob = 4
    case tracker = 5
}

// MARK: - Supporting Types
enum Gender: String, CaseIterable {
    case boy = "Boy"
    case girl = "Girl"
    case notSet = "Gender not set"
}

// MARK: - Main Content View
struct ContentView: View {
    @Query private var babies: [BabyProfile]
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @StateObject private var state = BabyAppState()
    
    var body: some View {
        Group {
            if hasCompletedOnboarding && !babies.isEmpty {
                MainTabView()
            } else {
                OnboardingFlowView(state: state)
            }
        }
    }
}

// MARK: - Onboarding Flow
struct OnboardingFlowView: View {
    @ObservedObject var state: BabyAppState
    @State private var step = 0
    @State private var isMovingForward = true
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            Group {
                switch step {
                case 0: LandingScreen(state: state)
                case 1: IntroScreen(state: state)
                case 2: NicknameScreen(state: state)
                case 3: GenderScreen(state: state)
                case 4: DOBScreen(state: state)
                default: LandingScreen(state: state)
                }
            }
            .transition(.asymmetric(
                insertion: .move(edge: isMovingForward ? .trailing : .leading).combined(with: .opacity),
                removal: .move(edge: isMovingForward ? .leading : .trailing).combined(with: .opacity)
            ))
        }
    }
    
    func next() {
        isMovingForward = true
        withAnimation(.easeInOut(duration: 0.3)) { step += 1 }
    }
    
    func back() {
        isMovingForward = false
        withAnimation(.easeInOut(duration: 0.3)) { step -= 1 }
    }
}

// MARK: - Colors (Injected for global availability)
extension Color {
    static let appBackground = Color(red: 28/255, green: 28/255, blue: 30/255)
    static let appAccent = Color(red: 249/255, green: 124/255, blue: 136/255)
    static let appDarkGray = Color(red: 36/255, green: 36/255, blue: 38/255)
    static let appMediumGray = Color(red: 58/255, green: 58/255, blue: 60/255)
    static let appTextSecondary = Color(red: 142/255, green: 142/255, blue: 147/255)
    static let timelineSidebar = Color(red: 44/255, green: 44/255, blue: 46/255)
    static let highlightBlue = Color(red: 100/255, green: 150/255, blue: 255/255)
}
