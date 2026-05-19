import SwiftUI

struct LighthouseKeeperLoadingScreen: View {
    @State private var pulse = false
    @State private var spin: Double = 0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {
                ZStack {
                    Circle()
                        .stroke(LighthouseKeeperPalette.sand.opacity(0.18), lineWidth: 2)
                        .frame(width: 160, height: 160)
                    Circle()
                        .trim(from: 0, to: 0.18)
                        .stroke(LighthouseKeeperPalette.amber, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 160, height: 160)
                        .rotationEffect(.degrees(spin))
                    Circle()
                        .fill(LighthouseKeeperPalette.amber.opacity(pulse ? 0.95 : 0.40))
                        .frame(width: 22, height: 22)
                }

                Text("Lighthouse Keeper")
                    .font(.system(size: 26, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)

                Text("Tending the lens. Listening to the cape.")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                HStack(spacing: 8) {
                    ForEach(0..<5, id: \.self) { i in
                        Capsule()
                            .fill(LighthouseKeeperPalette.amber.opacity(pulse ? 0.85 : 0.25))
                            .frame(width: 8, height: pulse ? 22 : 8)
                            .animation(.easeInOut(duration: 0.7).repeatForever().delay(Double(i) * 0.12), value: pulse)
                    }
                }
                .padding(.top, 6)
            }
        }
        .onAppear {
            pulse = true
            withAnimation(.linear(duration: 3.2).repeatForever(autoreverses: false)) {
                spin = 360
            }
        }
    }
}
