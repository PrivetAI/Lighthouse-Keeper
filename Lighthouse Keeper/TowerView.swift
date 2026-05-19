import SwiftUI

struct TowerView: View {
    @EnvironmentObject var store: LighthouseKeeperStore

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                topPanel
                if store.state.isDayPhase {
                    DayShiftPanel()
                } else {
                    NightShiftPanel()
                }
                statusGrid
                if store.state.nightIndex >= 120 {
                    finaleBanner
                }
                Spacer(minLength: 30)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle("The Tower", displayMode: .inline)
    }

    private var topPanel: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(store.currentSeason.label.uppercased())
                        .font(.system(size: 11, weight: .bold))
                        .tracking(2)
                        .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                    Text("Night \(store.state.nightIndex + 1) of 120")
                        .font(.system(size: 22, weight: .heavy, design: .serif))
                        .foregroundColor(LighthouseKeeperPalette.sand)
                }
                Spacer()
                seasonSeal
            }
            Text(store.currentSeason.ambientTone)
                .font(.system(size: 13))
                .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.75))
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 12) {
                WeatherGlyph(kind: store.currentWeather, size: 36, color: LighthouseKeeperPalette.amber)
                VStack(alignment: .leading, spacing: 2) {
                    Text(store.currentWeather.label)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(LighthouseKeeperPalette.sand)
                    Text(store.currentWeather.note)
                        .font(.system(size: 11))
                        .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.8))
                }
                Spacer()
            }
        }
        .padding(14)
        .background(
            LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(10)
    }

    private var seasonSeal: some View {
        ZStack {
            Circle()
                .stroke(LighthouseKeeperPalette.amber.opacity(0.8), lineWidth: 2)
                .frame(width: 54, height: 54)
            Circle()
                .fill(LighthouseKeeperPalette.seasonTint(store.currentSeason).opacity(0.6))
                .frame(width: 38, height: 38)
            Text("\(store.seasonNight)")
                .font(.system(size: 16, weight: .heavy))
                .foregroundColor(LighthouseKeeperPalette.sand)
        }
    }

    private var statusGrid: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                statusCard("Money", "\(store.state.money) m", LighthouseKeeperPalette.amber)
                statusCard("Fuel", "\(store.state.fuel)%", LighthouseKeeperPalette.rust)
            }
            HStack(spacing: 10) {
                statusCard("Fatigue", "\(store.state.fatigue)%", LighthouseKeeperPalette.slate)
                statusCard("Reputation", "\(store.state.reputation)", LighthouseKeeperPalette.teal)
            }
            HStack(spacing: 10) {
                statusCard("Log Pts", "\(store.state.logPoints)", LighthouseKeeperPalette.amber)
                statusCard("IDs", "\(store.state.totalIdentifiedCount)", LighthouseKeeperPalette.teal)
            }
        }
    }

    private func statusCard(_ title: String, _ value: String, _ accent: Color) -> some View {
        HStack {
            Rectangle().fill(accent).frame(width: 4)
            VStack(alignment: .leading, spacing: 2) {
                Text(title.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.5)
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                Text(value)
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
            }
            .padding(.vertical, 10)
            .padding(.leading, 6)
            Spacer()
        }
        .background(LighthouseKeeperPalette.surfaceSunken)
        .cornerRadius(6)
    }

    private var finaleBanner: some View {
        let ending = store.currentLikelyEnding()
        let leader = store.arcStandings.first
        return VStack(spacing: 6) {
            Text("WATCH COMPLETE")
                .font(.system(size: 16, weight: .black))
                .tracking(3)
                .foregroundColor(LighthouseKeeperPalette.amber)
            Text("Likely ending: \(endingTitle(ending))")
                .font(.system(size: 13, weight: .heavy, design: .serif))
                .foregroundColor(LighthouseKeeperPalette.sand)
            if let l = leader {
                Text("Leading arc: \(l.0.label) — score \(l.1)")
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.85))
            }
            Text("Open the Almanac for the full ending.")
                .font(.system(size: 11))
                .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.75))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(LighthouseKeeperPalette.teal)
        .cornerRadius(8)
    }

    private func endingTitle(_ e: LighthouseKeeperStore.Ending) -> String {
        switch e {
        case .family: return "Hearth Light"
        case .inspector: return "The Ledger Closed"
        case .aurora: return "Aurora's Margin"
        case .wreck: return "The Hull Remembered"
        case .smugglers: return "Low Tide Reckoning"
        }
    }
}

// MARK: - Day Shift Panel

enum ActiveDaySheet: Identifiable {
    case subsystem, inventory, cavePatrol
    var id: Int {
        switch self {
        case .subsystem: return 1
        case .inventory: return 2
        case .cavePatrol: return 3
        }
    }
}

struct DayShiftPanel: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @State private var activeSheet: ActiveDaySheet? = nil
    @State private var resultBanner: String? = nil

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Day Shift")
                    .font(.system(size: 18, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                Spacer()
                Text("Actions: \(store.state.dayActionsRemaining)/3")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(LighthouseKeeperPalette.rust)
            }
            LighthouseKeeperDivider(color: LighthouseKeeperPalette.divider)
            if let r = resultBanner {
                Text(r)
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background(LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
            }
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(DayAction.allCases, id: \.self) { action in
                    actionTile(action: action)
                }
            }
            Button {
                store.enterNightPhase()
            } label: {
                HStack {
                    Text("Begin Night Watch")
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
                    ChevronGlyph(direction: .right, size: 18, color: LighthouseKeeperPalette.teal)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
                .background(LighthouseKeeperPalette.amber)
                .foregroundColor(LighthouseKeeperPalette.teal)
                .cornerRadius(8)
            }
            .disabled(store.state.nightIndex >= 120)
            .opacity(store.state.nightIndex >= 120 ? 0.5 : 1)
        }
        .padding(14)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(LighthouseKeeperPalette.divider, lineWidth: 1)
        )
        .sheet(item: $activeSheet) { which in
            switch which {
            case .subsystem:
                SubsystemRepairPicker(onClose: { result in
                    resultBanner = result
                    activeSheet = nil
                })
                .environmentObject(store)
            case .inventory:
                InventorySheet().environmentObject(store)
            case .cavePatrol:
                CavePatrolResultSheet().environmentObject(store)
            }
        }
    }

    private func actionTile(action: DayAction) -> some View {
        let disabled = store.state.dayActionsRemaining <= 0 || (action == .patrolCave && !store.state.caveUnlocked)
        return Button {
            handleAction(action)
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                actionIcon(action)
                    .frame(width: 28, height: 28)
                Text(action.label)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                Text(action.description)
                    .font(.system(size: 11))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(disabled ? LighthouseKeeperPalette.surfaceSunken : LighthouseKeeperPalette.surface)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(disabled ? LighthouseKeeperPalette.divider : LighthouseKeeperPalette.amber.opacity(0.6), lineWidth: 1)
            )
            .opacity(disabled ? 0.55 : 1)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(disabled)
    }

    private func actionIcon(_ action: DayAction) -> some View {
        Group {
            switch action {
            case .repair:
                SettingsIcon(size: 28, color: LighthouseKeeperPalette.rust)
            case .inventory:
                Canvas { ctx, sz in
                    let w = sz.width, h = sz.height
                    var crate = Path(CGRect(x: w * 0.10, y: h * 0.20, width: w * 0.80, height: h * 0.70))
                    ctx.stroke(crate, with: .color(LighthouseKeeperPalette.slate), lineWidth: 2)
                    var bands = Path()
                    bands.move(to: CGPoint(x: w * 0.10, y: h * 0.50))
                    bands.addLine(to: CGPoint(x: w * 0.90, y: h * 0.50))
                    ctx.stroke(bands, with: .color(LighthouseKeeperPalette.slate), lineWidth: 2)
                }
                .frame(width: 28, height: 28)
            case .telegram:
                LetterIcon(size: 28, color: LighthouseKeeperPalette.teal)
            case .rest:
                Canvas { ctx, sz in
                    let w = sz.width, h = sz.height
                    var moon = Path()
                    moon.addArc(center: CGPoint(x: w * 0.5, y: h * 0.5), radius: w * 0.36, startAngle: .degrees(45), endAngle: .degrees(315), clockwise: false)
                    ctx.stroke(moon, with: .color(LighthouseKeeperPalette.slate), lineWidth: 2)
                }
                .frame(width: 28, height: 28)
            case .patrolCave:
                Canvas { ctx, sz in
                    let w = sz.width, h = sz.height
                    var p = Path()
                    p.move(to: CGPoint(x: w * 0.12, y: h * 0.88))
                    p.addLine(to: CGPoint(x: w * 0.50, y: h * 0.12))
                    p.addLine(to: CGPoint(x: w * 0.88, y: h * 0.88))
                    p.closeSubpath()
                    ctx.stroke(p, with: .color(LighthouseKeeperPalette.slate), lineWidth: 2)
                    var inner = Path(ellipseIn: CGRect(x: w * 0.36, y: h * 0.46, width: w * 0.28, height: h * 0.40))
                    ctx.fill(inner, with: .color(LighthouseKeeperPalette.slate))
                }
                .frame(width: 28, height: 28)
            case .studyRegistry:
                RegistryIcon(size: 28, color: LighthouseKeeperPalette.slate)
            }
        }
    }

    private func handleAction(_ action: DayAction) {
        resultBanner = nil
        // Hard guards: must be day phase with actions remaining.
        guard store.state.isDayPhase, store.state.dayActionsRemaining > 0 else {
            resultBanner = "No actions remain today."
            return
        }
        switch action {
        case .repair:
            // Only open the repair sheet if there's an action to spend.
            activeSheet = .subsystem
        case .inventory:
            store.performDayAction(.inventory)
            activeSheet = .inventory
        case .telegram:
            store.performDayAction(.telegram)
            NotificationCenter.default.post(name: .lighthouseKeeperSwitchToLettersTab, object: nil)
            resultBanner = "You spent an hour with the post bag. Opening Letters…"
        case .rest:
            store.performDayAction(.rest)
            resultBanner = "You rested. Fatigue is lower; tonight will pass slower."
        case .patrolCave:
            if !store.state.caveUnlocked {
                resultBanner = "The cave stair is not yet visible."
                return
            }
            store.performDayAction(.patrolCave)
            activeSheet = .cavePatrol
        case .studyRegistry:
            store.performDayAction(.studyRegistry)
            resultBanner = "You re-read the ship registry by lamp-light. Tonight's identifications will be sharper."
        }
        store.persist()
    }
}

extension Notification.Name {
    static let lighthouseKeeperSwitchToLettersTab = Notification.Name("lighthouseKeeperSwitchToLettersTab")
}

// MARK: - Night Shift Panel

enum ActiveNightSheet: Identifiable {
    case shipGuess(shipId: String)
    case weatherGuess
    var id: String {
        switch self {
        case .shipGuess(let s): return "ship:\(s)"
        case .weatherGuess: return "weather"
        }
    }
}

struct NightShiftPanel: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @State private var beamAngle: Double = -90
    @State private var passingShipIndex: Int = 0
    @State private var activeSheet: ActiveNightSheet? = nil
    @State private var lastIdMessage: String? = nil
    @State private var weatherGuessFeedback: String? = nil
    @State private var shipWindowDeadline: Date? = nil
    @State private var shipWindowTickNow: Date = Date()
    private let shipWindowSeconds: Double = 6.0
    private let shipWindowTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Text("Night Watch")
                    .font(.system(size: 18, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                Spacer()
                Text("Hour \(store.state.hourIndex + 1)/8")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(LighthouseKeeperPalette.teal)
            }
            LighthouseKeeperDivider(color: LighthouseKeeperPalette.divider)
            GeometryReader { geo in
                BeamCanvas(
                    screenSize: geo.size,
                    beamAngle: beamAngle,
                    weather: store.currentWeather,
                    queue: visibleQueue
                )
                .frame(width: geo.size.width, height: geo.size.width * 0.75)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { v in
                            let cx = geo.size.width / 2
                            let cy = geo.size.width * 0.75 / 2 + geo.size.width * 0.20
                            let dx = v.location.x - cx
                            let dy = v.location.y - cy
                            let ang = atan2(Double(dy), Double(dx)) * 180.0 / .pi
                            beamAngle = ang
                        }
                )
            }
            .frame(height: 240)

            if let cur = currentShipId {
                VStack(spacing: 6) {
                    Button {
                        activeSheet = .shipGuess(shipId: cur)
                    } label: {
                        HStack {
                            Text("Identify Ship in Beam")
                                .font(.system(size: 14, weight: .bold))
                            Spacer()
                            ChevronGlyph(direction: .right, size: 16, color: LighthouseKeeperPalette.teal)
                        }
                        .padding(12)
                        .background(LighthouseKeeperPalette.amber)
                        .foregroundColor(LighthouseKeeperPalette.teal)
                        .cornerRadius(8)
                    }
                    if let remaining = shipWindowRemaining() {
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule().fill(LighthouseKeeperPalette.divider).frame(height: 4)
                                Capsule()
                                    .fill(remaining < 1.5 ? LighthouseKeeperPalette.rust : LighthouseKeeperPalette.teal)
                                    .frame(width: max(2, geo.size.width * CGFloat(remaining / shipWindowSeconds)), height: 4)
                            }
                        }
                        .frame(height: 4)
                        Text("Window: \(String(format: "%.1f", remaining))s — ship will pass anonymously when it runs out.")
                            .font(.system(size: 10))
                            .foregroundColor(LighthouseKeeperPalette.inkMid)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            if let m = lastIdMessage {
                Text(m)
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
            }

            HStack(spacing: 10) {
                Button {
                    if !store.state.loggedWeatherThisNight {
                        activeSheet = .weatherGuess
                    }
                } label: {
                    HStack {
                        WeatherGlyph(kind: store.currentWeather, size: 22, color: LighthouseKeeperPalette.amber)
                        Text(store.state.loggedWeatherThisNight ? "Weather Logged" : "Log Weather")
                            .font(.system(size: 13, weight: .bold))
                        Spacer()
                    }
                    .padding(10)
                    .background(LighthouseKeeperPalette.surface)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
                }
                .disabled(store.state.loggedWeatherThisNight)
                Button {
                    store.advanceHour()
                    passingShipIndex = store.state.tonightShipsResolved.count
                    lastIdMessage = nil
                } label: {
                    HStack {
                        Text("Advance Hour")
                            .font(.system(size: 13, weight: .bold))
                        Spacer()
                        ChevronGlyph(direction: .right, size: 16, color: LighthouseKeeperPalette.sand)
                    }
                    .padding(10)
                    .background(LighthouseKeeperPalette.teal)
                    .foregroundColor(LighthouseKeeperPalette.sand)
                    .cornerRadius(6)
                }
            }
            if let wf = weatherGuessFeedback {
                Text(wf)
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
            }
        }
        .padding(14)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
        .sheet(item: $activeSheet) { which in
            switch which {
            case .shipGuess(let pid):
                ShipIdentifySheet(shipId: pid) { ok in
                    resolveShipGuess(shipId: pid, correctGuess: ok)
                    activeSheet = nil
                }
                .environmentObject(store)
            case .weatherGuess:
                WeatherGuessSheet { picked in
                    let actual = store.currentWeather
                    let ok = store.logWeather(picked)
                    if ok {
                        weatherGuessFeedback = "Correct: \(actual.label). +5 weather mastery, +2 log points."
                    } else {
                        weatherGuessFeedback = "You guessed \(picked.label). The horizon disagreed (\(actual.label))."
                    }
                    activeSheet = nil
                }
            }
        }
        .onAppear {
            passingShipIndex = store.state.tonightShipsResolved.count
            armShipWindowIfNeeded()
        }
        .onChange(of: store.state.tonightShipsResolved.count) { _ in
            armShipWindowIfNeeded()
        }
        .onReceive(shipWindowTimer) { now in
            shipWindowTickNow = now
            checkShipWindowExpiry()
        }
    }

    private func resolveShipGuess(shipId: String, correctGuess: Bool) {
        let weather = store.currentWeather
        let success = store.attemptIdentifyShip(shipId, correctGuess: correctGuess)
        if !correctGuess {
            lastIdMessage = "You guessed wrong; the ship passed anonymously."
        } else if success {
            if let ship = LighthouseKeeperCatalog.ships.first(where: { $0.id == shipId }) {
                lastIdMessage = "Identified: \(ship.name) (\(ship.flag))."
            }
            // wreckSurvivor: aiding a vessel through gale/storm/blizzard/iceRain weather.
            if weather.isStormy {
                store.markStormAid()
            }
        } else {
            lastIdMessage = "You knew it, but the weather defeated you. Ship passed anonymously."
        }
        passingShipIndex = store.state.tonightShipsResolved.count
        shipWindowDeadline = nil
    }

    private func armShipWindowIfNeeded() {
        if currentShipId != nil {
            if shipWindowDeadline == nil {
                shipWindowDeadline = Date().addingTimeInterval(shipWindowSeconds)
            }
        } else {
            shipWindowDeadline = nil
        }
    }

    private func shipWindowRemaining() -> Double? {
        guard let deadline = shipWindowDeadline else { return nil }
        let remaining = deadline.timeIntervalSince(shipWindowTickNow)
        return max(0, remaining)
    }

    private func checkShipWindowExpiry() {
        guard let deadline = shipWindowDeadline, let cur = currentShipId else { return }
        if shipWindowTickNow >= deadline {
            // Time out: ship passes anonymously.
            _ = store.attemptIdentifyShip(cur, correctGuess: false)
            lastIdMessage = "The window closed; the ship passed anonymously."
            passingShipIndex = store.state.tonightShipsResolved.count
            shipWindowDeadline = nil
        }
    }

    private var currentShipId: String? {
        let resolved = store.state.tonightShipsResolved.count
        if resolved >= store.state.tonightShipQueue.count { return nil }
        return store.state.tonightShipQueue[resolved]
    }

    private var visibleQueue: [String] {
        // Up to 3 ships visible at a time: the next unresolved + 2 upcoming
        let resolved = store.state.tonightShipsResolved.count
        let upcoming = store.state.tonightShipQueue.dropFirst(resolved)
        return Array(upcoming.prefix(3))
    }
}

// MARK: - Beam Canvas

struct BeamCanvas: View {
    let screenSize: CGSize
    let beamAngle: Double
    let weather: WeatherKind
    let queue: [String]

    var body: some View {
        let w = screenSize.width
        let h = screenSize.width * 0.75
        let cx = w / 2
        let cy = h / 2 + w * 0.20
        let beamLen = w * weather.beamRange * 0.55

        return ZStack {
            Canvas { ctx, _ in
                // Night sea
                var sea = Path()
                sea.addRect(CGRect(x: 0, y: 0, width: w, height: h))
                ctx.fill(sea, with: .linearGradient(
                    Gradient(colors: [LighthouseKeeperPalette.slate, LighthouseKeeperPalette.teal]),
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: 0, y: h)
                ))
                // Stars
                for i in 0..<30 {
                    let sx = CGFloat((i * 73) % Int(w))
                    let sy = CGFloat((i * 37) % Int(h * 0.6))
                    var s = Path(ellipseIn: CGRect(x: sx, y: sy, width: 2, height: 2))
                    ctx.fill(s, with: .color(LighthouseKeeperPalette.sand.opacity(0.6)))
                }
                // Lighthouse silhouette
                var tower = Path()
                tower.move(to: CGPoint(x: cx - 12, y: cy + 60))
                tower.addLine(to: CGPoint(x: cx - 8, y: cy - 30))
                tower.addLine(to: CGPoint(x: cx + 8, y: cy - 30))
                tower.addLine(to: CGPoint(x: cx + 12, y: cy + 60))
                tower.closeSubpath()
                ctx.fill(tower, with: .color(LighthouseKeeperPalette.inkDark))
                var lantern = Path(CGRect(x: cx - 14, y: cy - 42, width: 28, height: 14))
                ctx.fill(lantern, with: .color(LighthouseKeeperPalette.amber.opacity(0.85)))

                // Beam cone
                let rad = beamAngle * .pi / 180.0
                let spread = 0.34
                let p1 = CGPoint(x: cx, y: cy - 35)
                let p2 = CGPoint(x: cx + CGFloat(cos(rad - spread)) * beamLen,
                                 y: cy - 35 + CGFloat(sin(rad - spread)) * beamLen)
                let p3 = CGPoint(x: cx + CGFloat(cos(rad + spread)) * beamLen,
                                 y: cy - 35 + CGFloat(sin(rad + spread)) * beamLen)
                var beam = Path()
                beam.move(to: p1)
                beam.addLine(to: p2)
                beam.addLine(to: p3)
                beam.closeSubpath()
                ctx.fill(beam, with: .linearGradient(
                    Gradient(colors: [LighthouseKeeperPalette.amber.opacity(0.55), LighthouseKeeperPalette.amber.opacity(0.05)]),
                    startPoint: p1,
                    endPoint: CGPoint(x: (p2.x + p3.x)/2, y: (p2.y + p3.y)/2)
                ))

                // Compass
                var circle = Path(ellipseIn: CGRect(x: cx - 70, y: cy - 8, width: 140, height: 30))
                ctx.stroke(circle, with: .color(LighthouseKeeperPalette.sand.opacity(0.15)), lineWidth: 1)
            }
            // Ships (overlay so they can use ShipSilhouette views)
            ForEach(Array(queue.enumerated()), id: \.offset) { idx, shipId in
                if let ship = LighthouseKeeperCatalog.ships.first(where: { $0.id == shipId }) {
                    let radius = beamLen * 0.85 - CGFloat(idx) * 30
                    // Place ships around the horizon at different angles
                    let baseAngle: Double = -150 + Double(idx) * 50
                    let r = baseAngle * .pi / 180
                    let x = cx + CGFloat(cos(r)) * radius
                    let y = cy - 35 + CGFloat(sin(r)) * radius
                    ShipSilhouette(
                        kind: ship.kind,
                        color: shipColor(angle: baseAngle),
                        size: CGSize(width: 70, height: 35)
                    )
                    .position(x: x, y: y)
                    .opacity(beamHits(baseAngle) ? 1.0 : 0.32)
                }
            }
        }
    }

    private func beamHits(_ shipAngleDeg: Double) -> Bool {
        let diff = (shipAngleDeg - beamAngle).truncatingRemainder(dividingBy: 360)
        let norm = ((diff + 540).truncatingRemainder(dividingBy: 360)) - 180
        return abs(norm) <= 25
    }

    private func shipColor(angle: Double) -> Color {
        return beamHits(angle) ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.sand.opacity(0.35)
    }
}
