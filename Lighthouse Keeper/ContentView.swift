import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @State private var selectedTab: Int = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case 0:
                        NavigationView { TowerView() }
                            .navigationViewStyle(StackNavigationViewStyle())
                    case 1:
                        NavigationView { RegistryView() }
                            .navigationViewStyle(StackNavigationViewStyle())
                    case 2:
                        NavigationView { LettersView() }
                            .navigationViewStyle(StackNavigationViewStyle())
                    case 3:
                        NavigationView { JournalView() }
                            .navigationViewStyle(StackNavigationViewStyle())
                    case 4:
                        NavigationView { AlmanacView() }
                            .navigationViewStyle(StackNavigationViewStyle())
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Custom Tab Bar
                tabBar
            }
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .onReceive(NotificationCenter.default.publisher(for: .lighthouseKeeperSwitchToLettersTab)) { _ in
            selectedTab = 2
        }
    }

    private var tabBar: some View {
        HStack(spacing: 0) {
            tabButton(0, label: "Tower",   icon: AnyView(TowerIcon(size: 26,    color: tint(0))))
            tabButton(1, label: "Registry",icon: AnyView(RegistryIcon(size: 26, color: tint(1))))
            tabButton(2, label: "Letters", icon: AnyView(LetterIcon(size: 26,   color: tint(2))))
            tabButton(3, label: "Journal", icon: AnyView(JournalIcon(size: 26,  color: tint(3))))
            tabButton(4, label: "Almanac", icon: AnyView(AlmanacIcon(size: 26,  color: tint(4))))
        }
        .padding(.top, 8)
        .padding(.bottom, 6)
        .background(
            LighthouseKeeperPalette.teal
                .overlay(
                    Rectangle()
                        .fill(LighthouseKeeperPalette.amber.opacity(0.5))
                        .frame(height: 1),
                    alignment: .top
                )
                .edgesIgnoringSafeArea(.bottom)
        )
    }

    private func tint(_ idx: Int) -> Color {
        selectedTab == idx ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.sand.opacity(0.55)
    }

    private func tabButton(_ index: Int, label: String, icon: AnyView) -> some View {
        Button {
            selectedTab = index
        } label: {
            VStack(spacing: 3) {
                icon
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(tint(index))
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
