import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isDisabled: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.system(size: 18, weight: .bold))
                .foregroundColor(isDisabled ? Color.white.opacity(0.8) : Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(isDisabled ? Color.appAccent.opacity(0.5) : Color.appAccent)
                .cornerRadius(30)
        }
        .disabled(isDisabled)
    }
}

struct OutlineButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.system(size: 18, weight: .bold))
                .foregroundColor(Color.appAccent)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.appAccent, lineWidth: 1)
                )
        }
    }
}

struct BackHeader: View {
    var subtitle: String?
    var title: AnyView?
    let onBack: () -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Button(action: onBack) {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 20, weight: .semibold))
                        Text("Back")
                            .font(Font.system(size: 18, weight: .medium))
                    }
                    .foregroundColor(Color.appAccent)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            VStack(spacing: 4) {
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(Color.appAccent)
                }
                if let title = title {
                    title
                }
            }
            .padding(.top, 40)
        }
    }
}

struct ProgressBar: View {
    let step: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...3, id: \.self) { i in
                Rectangle()
                    .fill(step >= i ? Color.appAccent : Color.white.opacity(0.2))
                    .frame(height: 8)
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 16)
    }
}
