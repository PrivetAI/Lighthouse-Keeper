import SwiftUI

struct AlmanacView: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @State private var showSettings = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                arcsSection
                cavesSection
                achievementsSection
                if store.state.nightIndex >= 120 {
                    endingsSection
                }
                relationshipsSection
                weatherCodexSection
                settingsButton
                Spacer(minLength: 30)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle("Almanac", displayMode: .inline)
        .sheet(isPresented: $showSettings) {
            LighthouseKeeperSettingsView().environmentObject(store)
        }
    }

    private var arcsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Narrative Arcs", subtitle: "Five parallel arcs run alongside your watch.")
            ForEach(store.arcStandings, id: \.0) { (arc, score) in
                arcBar(arc, score: score)
            }
        }
    }

    private func arcBar(_ arc: ArcKind, score: Int) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(arc.label)
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                Spacer()
                Text("\(score)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(score > 0 ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.rust)
            }
            ZStack(alignment: .leading) {
                Rectangle().fill(LighthouseKeeperPalette.divider).frame(height: 6).cornerRadius(2)
                Rectangle()
                    .fill(score > 0 ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.rust)
                    .frame(width: max(8, CGFloat(min(80, max(-40, score)) + 40)) * 2.5, height: 6)
                    .cornerRadius(2)
            }
            Text(arc.summary)
                .font(.system(size: 11))
                .foregroundColor(LighthouseKeeperPalette.inkMid)
                .lineLimit(3)
        }
        .padding(10)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(6)
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
    }

    private var cavesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Cliff Cave", subtitle: store.state.caveUnlocked ? "Discovered at the foot of the cape." : "Unlocks after night 40.")
            HStack {
                Text("Artifacts collected")
                    .font(.system(size: 12)).foregroundColor(LighthouseKeeperPalette.inkMid)
                Spacer()
                Text("\(store.state.caveArtifacts.count) / \(CaveArtifact.allCases.count)")
                    .font(.system(size: 14, weight: .heavy)).foregroundColor(LighthouseKeeperPalette.teal)
            }
            .padding(10)
            .background(LighthouseKeeperPalette.surfaceSunken)
            .cornerRadius(6)
            if store.state.caveArtifacts.isEmpty {
                Text(store.state.caveUnlocked ? "Patrol the cave on a day shift to begin collecting." : "The stair is not yet visible.")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                    ForEach(Array(store.state.caveArtifacts).sorted(), id: \.self) { raw in
                        if let art = CaveArtifact(rawValue: raw) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(art.label)
                                    .font(.system(size: 12, weight: .heavy))
                                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                                Text(art.lore)
                                    .font(.system(size: 10))
                                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                                    .lineLimit(4)
                            }
                            .padding(8)
                            .background(LighthouseKeeperPalette.surfaceSunken)
                            .cornerRadius(6)
                        }
                    }
                }
            }
        }
    }

    private var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Achievements", subtitle: "\(store.state.achievementsEarned.count) of \(AchievementKind.allCases.count) earned")
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                ForEach(AchievementKind.allCases, id: \.self) { a in
                    let earned = store.state.achievementsEarned.contains(a.rawValue)
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            if earned {
                                CheckGlyph(size: 16, color: LighthouseKeeperPalette.teal)
                            } else {
                                XGlyph(size: 14, color: LighthouseKeeperPalette.inkSoft)
                            }
                            Text(a.label)
                                .font(.system(size: 12, weight: .heavy))
                                .foregroundColor(earned ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkMid)
                                .lineLimit(1)
                        }
                        Text(a.hint)
                            .font(.system(size: 10))
                            .foregroundColor(LighthouseKeeperPalette.inkMid)
                            .lineLimit(2)
                    }
                    .padding(8)
                    .background(earned ? LighthouseKeeperPalette.surface : LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(earned ? LighthouseKeeperPalette.teal.opacity(0.6) : LighthouseKeeperPalette.divider, lineWidth: 1))
                }
            }
        }
    }

    private var endingsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Ending", subtitle: "The arc that dominated decides.")
            let e = store.currentLikelyEnding()
            VStack(alignment: .leading, spacing: 6) {
                Text(endingTitle(e))
                    .font(.system(size: 16, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.amber)
                Text(endingBody(e))
                    .font(.system(size: 13, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)
                    .lineSpacing(4)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(8)
        }
    }

    private func endingTitle(_ e: LighthouseKeeperStore.Ending) -> String {
        switch e {
        case .family: return "Hearth Light"
        case .inspector: return "The Ledger Closed"
        case .aurora: return "Aurora’s Margin"
        case .wreck: return "The Hull Remembered"
        case .smugglers: return "Low Tide Reckoning"
        }
    }

    private func endingBody(_ e: LighthouseKeeperStore.Ending) -> String {
        switch e {
        case .family:
            return "On the morning after the 120th night, you write the last log, leave the keys hanging on the lens-room hook, and walk down the headland trail with the wind at your back. Mira and Calla are waiting at the harbor inn. The lamp will turn without you tonight — Olen will see to that. You go home for good."
        case .inspector:
            return "Inspector Hess hands you the Senior Keeper certificate on the gallery in the first thin light. Three capes are now under your watch; you will inland the family in stages. Procedure has its own dignity. The lamp salutes you."
        case .aurora:
            return "On the 120th night, you dim the lamp. The aurora answers — green ribbons reach the rocks. You see, briefly, the cape as something older than your country, and then the lamp is lit again and you are alone in the lantern room, hand on the brass, and you know what the cape kept. You write nothing of it."
        case .wreck:
            return "On the morning after the 120th night, the cape gives up its dead. Divers haul the Sundered Hull's strongbox into your boathouse and Tobias' name is carved into the harbor stone. The cape will not need to hold this secret any longer — and neither will you."
        case .smugglers:
            return "Harbor-Master Vaal posts the list at dawn: every hold that ever called the cape at low tide, every flagged keel. The customs cutters work all morning. You sign every page. The cape's beam was never theirs to use, and now everyone knows it."
        }
    }

    private var relationshipsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Correspondents", subtitle: "Standing with the eight people who write to you.")
            ForEach(CorrespondentKind.allCases, id: \.self) { c in
                relationshipRow(c)
            }
        }
    }

    private func relationshipRow(_ c: CorrespondentKind) -> some View {
        let score = store.state.relationships[c.rawValue] ?? 0
        return HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(c.displayName)
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                Text("Arc: \(c.arc.label)")
                    .font(.system(size: 10))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
            }
            Spacer()
            Text("\(score)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(score > 0 ? LighthouseKeeperPalette.teal : (score < 0 ? LighthouseKeeperPalette.rust : LighthouseKeeperPalette.inkMid))
        }
        .padding(10)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(6)
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
    }

    private var weatherCodexSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Weather Codex", subtitle: "Mastery: \(store.state.weatherMasteryXP) XP")
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(WeatherKind.allCases, id: \.self) { w in
                    let logged = store.state.loggedWeathers.contains(w.rawValue)
                    VStack(spacing: 4) {
                        WeatherGlyph(kind: w, size: 28, color: logged ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.inkSoft)
                        Text(w.label)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(logged ? LighthouseKeeperPalette.inkDark : LighthouseKeeperPalette.inkMid)
                    }
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(logged ? LighthouseKeeperPalette.surface : LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(logged ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.divider, lineWidth: 1))
                }
            }
        }
    }

    private var settingsButton: some View {
        Button {
            showSettings = true
        } label: {
            HStack {
                SettingsIcon(size: 18, color: LighthouseKeeperPalette.teal)
                Text("Settings")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(LighthouseKeeperPalette.teal)
                Spacer()
                ChevronGlyph(direction: .right, size: 14, color: LighthouseKeeperPalette.inkSoft)
            }
            .padding(12)
            .background(LighthouseKeeperPalette.surfaceSunken)
            .cornerRadius(8)
        }
    }

    private func sectionHeader(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .tracking(2)
                .foregroundColor(LighthouseKeeperPalette.rust)
            Text(subtitle)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(LighthouseKeeperPalette.inkDark)
            LighthouseKeeperDivider(color: LighthouseKeeperPalette.divider)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Settings View (with Privacy Policy)

struct LighthouseKeeperSettingsView: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @Environment(\.presentationMode) var presentation
    @State private var showPrivacy = false
    @State private var showResetConfirm = false

    var body: some View {
        VStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text("SETTINGS")
                    .font(.system(size: 11, weight: .bold)).tracking(2).foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                Text("Lighthouse Keeper")
                    .font(.system(size: 20, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)
                Text("Version 1.0")
                    .font(.system(size: 12)).foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
            }
            .padding(14).frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .leading, endPoint: .trailing))

            VStack(spacing: 10) {
                settingsRow("Privacy Policy") { showPrivacy = true }
                settingsRow("About this Watch", trailingText: "120 nights, 4 seasons") { }
                settingsRow("Reset Save", destructive: true) { showResetConfirm = true }
            }
            .padding(.horizontal, 14)

            Spacer()
            Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Close")
                    .font(.system(size: 13, weight: .bold))
                    .padding(.horizontal, 22).padding(.vertical, 10)
                    .background(LighthouseKeeperPalette.teal)
                    .foregroundColor(LighthouseKeeperPalette.sand)
                    .cornerRadius(6)
            }
            .padding(.bottom, 16)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .preferredColorScheme(.light)
        .sheet(isPresented: $showPrivacy) {
            LighthouseKeeperWebPanel(urlString: "https://lighthousekeeper.org/click.php")
                .edgesIgnoringSafeArea(.all)
        }
        .alert(isPresented: $showResetConfirm) {
            Alert(
                title: Text("Reset Save?"),
                message: Text("This wipes all progress. Are you sure?"),
                primaryButton: .destructive(Text("Reset")) {
                    store.resetGame()
                },
                secondaryButton: .cancel()
            )
        }
    }

    private func settingsRow(_ title: String, trailingText: String? = nil, destructive: Bool = false, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(destructive ? LighthouseKeeperPalette.rust : LighthouseKeeperPalette.inkDark)
                Spacer()
                if let t = trailingText {
                    Text(t)
                        .font(.system(size: 11))
                        .foregroundColor(LighthouseKeeperPalette.inkMid)
                }
                ChevronGlyph(direction: .right, size: 14, color: LighthouseKeeperPalette.inkSoft)
            }
            .padding(12)
            .background(LighthouseKeeperPalette.surfaceSunken)
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(destructive ? LighthouseKeeperPalette.rust.opacity(0.4) : LighthouseKeeperPalette.divider, lineWidth: 1))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
