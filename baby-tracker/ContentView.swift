import SwiftUI
import SwiftData
import Combine

// MARK: - App Models
enum AppStep: Int {
    case landing = 0
    case intro = 1
    case nickname = 2
    case gender = 3
    case dob = 4
    case tracker = 5
}

enum Gender: String, CaseIterable {
    case boy = "Boy"
    case girl = "Girl"
    case notSet = "Gender not set"
}

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

// MARK: - Main Content View
struct ContentView: View {
    @Query private var babies: [BabyProfile]
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @StateObject private var state = BabyAppState()
    
    var body: some View {
        ZStack {
            Color.appDarkGray.ignoresSafeArea()
            
            Group {
                // If we have babies, go to tracker. Otherwise, onboarding.
                if !babies.isEmpty && hasCompletedOnboarding {
                    TrackerScreen(state: state)
                } else {
                    OnboardingFlowView(state: state)
                }
            }
        }
    }
}

// MARK: - Onboarding Flow
struct OnboardingFlowView: View {
    @ObservedObject var state: BabyAppState
    
    var body: some View {
        Group {
            switch state.currentStep {
            case .landing:
                LandingScreen(state: state)
            case .intro:
                IntroScreen(state: state)
            case .nickname:
                NicknameScreen(state: state)
            case .gender:
                GenderScreen(state: state)
            case .dob:
                DOBScreen(state: state)
            case .tracker:
                TrackerScreen(state: state)
            }
        }
        .transition(.asymmetric(
            insertion: .move(edge: state.isMovingForward ? .trailing : .leading).combined(with: .opacity),
            removal: .move(edge: state.isMovingForward ? .leading : .trailing).combined(with: .opacity)
        ))
    }
}
