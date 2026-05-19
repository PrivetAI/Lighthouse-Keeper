import Foundation
import SwiftUI

// MARK: - Persisted state (Codable)

struct LighthouseKeeperState: Codable {
    // Time
    var nightIndex: Int                 // 0...119
    var hourIndex: Int                  // 0...7 within current night
    var dayActionsRemaining: Int        // 0...3 fresh each day
    var isDayPhase: Bool                // when true: player chooses day actions; when false: night watch

    // Resources
    var money: Int
    var fuel: Int                       // 0...100
    var fatigue: Int                    // 0...100
    var reputation: Int                 // -50...100
    var logPoints: Int

    // Subsystems
    var subsystemCondition: [String: Int]  // SubsystemKind.rawValue -> 0..100
    var subsystemRepairCount: [String: Int]

    // Parts inventory
    var partsInventory: [String: Int]   // InventoryPart.rawValue -> count

    // Relationships
    var relationships: [String: Int]    // CorrespondentKind.rawValue -> -50..100

    // Arc scores
    var arcScores: [String: Int]        // ArcKind.rawValue -> -50..100

    // Letters
    var letterRecords: [LetterRecord]

    // Story flags
    var flags: Set<String>

    // Identified ships
    var identifiedShips: Set<String>    // ShipRegistryEntry.id
    var totalIdentifiedCount: Int

    // Weather logging
    var loggedWeathers: Set<String>     // WeatherKind.rawValue
    var weatherMasteryXP: Int
    var lastNightWeather: String?       // raw for the current night

    // Cave
    var caveUnlocked: Bool
    var caveArtifacts: Set<String>      // CaveArtifact.rawValue
    var lastCaveArtifactId: String?     // most-recently discovered artifact

    // Journal
    var journal: [JournalEntry]

    // Achievements
    var achievementsEarned: Set<String> // AchievementKind.rawValue

    // RNG seed
    var rngSeed: UInt64

    // Day-shift buffs for current night
    var registryStudyBuff: Bool
    var restedBuff: Bool

    // Did we already log weather correctly this night?
    var loggedWeatherThisNight: Bool

    // Ship tonight pre-rolled (kept persistent so it survives kill)
    var tonightShipQueue: [String]      // ship ids in pass order
    var tonightShipsResolved: [String]  // shipId for those passing windows already concluded
    var tonightIdentifiedSoFar: Int

    static func initial() -> LighthouseKeeperState {
        var subs: [String: Int] = [:]
        var subsRepair: [String: Int] = [:]
        for k in SubsystemKind.allCases {
            subs[k.rawValue] = 78 + Int.random(in: 0...10)
            subsRepair[k.rawValue] = 0
        }
        var parts: [String: Int] = [:]
        for p in InventoryPart.allCases { parts[p.rawValue] = 2 }
        var rels: [String: Int] = [:]
        for c in CorrespondentKind.allCases { rels[c.rawValue] = 0 }
        var arcs: [String: Int] = [:]
        for a in ArcKind.allCases { arcs[a.rawValue] = 0 }
        return LighthouseKeeperState(
            nightIndex: 0,
            hourIndex: 0,
            dayActionsRemaining: 3,
            isDayPhase: true,
            money: 80,
            fuel: 100,
            fatigue: 10,
            reputation: 5,
            logPoints: 0,
            subsystemCondition: subs,
            subsystemRepairCount: subsRepair,
            partsInventory: parts,
            relationships: rels,
            arcScores: arcs,
            letterRecords: [],
            flags: [],
            identifiedShips: [],
            totalIdentifiedCount: 0,
            loggedWeathers: [],
            weatherMasteryXP: 0,
            lastNightWeather: nil,
            caveUnlocked: false,
            caveArtifacts: [],
            lastCaveArtifactId: nil,
            journal: [],
            achievementsEarned: [],
            rngSeed: UInt64.random(in: 1...UInt64.max),
            registryStudyBuff: false,
            restedBuff: false,
            loggedWeatherThisNight: false,
            tonightShipQueue: [],
            tonightShipsResolved: [],
            tonightIdentifiedSoFar: 0
        )
    }
}

// MARK: - Robust decoding for forward-compat saves

extension LighthouseKeeperState {
    private enum DecKeys: String, CodingKey {
        case nightIndex, hourIndex, dayActionsRemaining, isDayPhase
        case money, fuel, fatigue, reputation, logPoints
        case subsystemCondition, subsystemRepairCount, partsInventory
        case relationships, arcScores, letterRecords, flags
        case identifiedShips, totalIdentifiedCount
        case loggedWeathers, weatherMasteryXP, lastNightWeather
        case caveUnlocked, caveArtifacts, lastCaveArtifactId
        case journal, achievementsEarned, rngSeed
        case registryStudyBuff, restedBuff, loggedWeatherThisNight
        case tonightShipQueue, tonightShipsResolved, tonightIdentifiedSoFar
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: DecKeys.self)
        let initial = LighthouseKeeperState.initial()
        self.nightIndex = try c.decodeIfPresent(Int.self, forKey: .nightIndex) ?? initial.nightIndex
        self.hourIndex = try c.decodeIfPresent(Int.self, forKey: .hourIndex) ?? initial.hourIndex
        self.dayActionsRemaining = try c.decodeIfPresent(Int.self, forKey: .dayActionsRemaining) ?? initial.dayActionsRemaining
        self.isDayPhase = try c.decodeIfPresent(Bool.self, forKey: .isDayPhase) ?? initial.isDayPhase
        self.money = try c.decodeIfPresent(Int.self, forKey: .money) ?? initial.money
        self.fuel = try c.decodeIfPresent(Int.self, forKey: .fuel) ?? initial.fuel
        self.fatigue = try c.decodeIfPresent(Int.self, forKey: .fatigue) ?? initial.fatigue
        self.reputation = try c.decodeIfPresent(Int.self, forKey: .reputation) ?? initial.reputation
        self.logPoints = try c.decodeIfPresent(Int.self, forKey: .logPoints) ?? initial.logPoints
        self.subsystemCondition = try c.decodeIfPresent([String: Int].self, forKey: .subsystemCondition) ?? initial.subsystemCondition
        self.subsystemRepairCount = try c.decodeIfPresent([String: Int].self, forKey: .subsystemRepairCount) ?? initial.subsystemRepairCount
        self.partsInventory = try c.decodeIfPresent([String: Int].self, forKey: .partsInventory) ?? initial.partsInventory
        self.relationships = try c.decodeIfPresent([String: Int].self, forKey: .relationships) ?? initial.relationships
        self.arcScores = try c.decodeIfPresent([String: Int].self, forKey: .arcScores) ?? initial.arcScores
        self.letterRecords = try c.decodeIfPresent([LetterRecord].self, forKey: .letterRecords) ?? initial.letterRecords
        self.flags = try c.decodeIfPresent(Set<String>.self, forKey: .flags) ?? initial.flags
        self.identifiedShips = try c.decodeIfPresent(Set<String>.self, forKey: .identifiedShips) ?? initial.identifiedShips
        self.totalIdentifiedCount = try c.decodeIfPresent(Int.self, forKey: .totalIdentifiedCount) ?? initial.totalIdentifiedCount
        self.loggedWeathers = try c.decodeIfPresent(Set<String>.self, forKey: .loggedWeathers) ?? initial.loggedWeathers
        self.weatherMasteryXP = try c.decodeIfPresent(Int.self, forKey: .weatherMasteryXP) ?? initial.weatherMasteryXP
        self.lastNightWeather = try c.decodeIfPresent(String.self, forKey: .lastNightWeather)
        self.caveUnlocked = try c.decodeIfPresent(Bool.self, forKey: .caveUnlocked) ?? initial.caveUnlocked
        self.caveArtifacts = try c.decodeIfPresent(Set<String>.self, forKey: .caveArtifacts) ?? initial.caveArtifacts
        self.lastCaveArtifactId = try c.decodeIfPresent(String.self, forKey: .lastCaveArtifactId)
        self.journal = try c.decodeIfPresent([JournalEntry].self, forKey: .journal) ?? initial.journal
        self.achievementsEarned = try c.decodeIfPresent(Set<String>.self, forKey: .achievementsEarned) ?? initial.achievementsEarned
        self.rngSeed = try c.decodeIfPresent(UInt64.self, forKey: .rngSeed) ?? initial.rngSeed
        self.registryStudyBuff = try c.decodeIfPresent(Bool.self, forKey: .registryStudyBuff) ?? initial.registryStudyBuff
        self.restedBuff = try c.decodeIfPresent(Bool.self, forKey: .restedBuff) ?? initial.restedBuff
        self.loggedWeatherThisNight = try c.decodeIfPresent(Bool.self, forKey: .loggedWeatherThisNight) ?? initial.loggedWeatherThisNight
        self.tonightShipQueue = try c.decodeIfPresent([String].self, forKey: .tonightShipQueue) ?? initial.tonightShipQueue
        self.tonightShipsResolved = try c.decodeIfPresent([String].self, forKey: .tonightShipsResolved) ?? initial.tonightShipsResolved
        self.tonightIdentifiedSoFar = try c.decodeIfPresent(Int.self, forKey: .tonightIdentifiedSoFar) ?? initial.tonightIdentifiedSoFar
    }
}

// MARK: - Store

final class LighthouseKeeperStore: ObservableObject {
    @Published var state: LighthouseKeeperState

    private let storageKey = "lk.state.v1"
    private let defaults = UserDefaults.standard

    init() {
        if let data = UserDefaults.standard.data(forKey: "lk.state.v1"),
           let decoded = try? JSONDecoder().decode(LighthouseKeeperState.self, from: data) {
            self.state = decoded
        } else {
            self.state = LighthouseKeeperState.initial()
        }
    }

    // MARK: - Persistence
    func persist() {
        guard let data = try? JSONEncoder().encode(state) else { return }
        defaults.set(data, forKey: storageKey)
    }

    func resetGame() {
        state = LighthouseKeeperState.initial()
        persist()
    }

    // MARK: - Derived

    var currentSeason: Season { Season.of(nightIndex: state.nightIndex) }
    var seasonNight: Int { state.nightIndex % 30 + 1 }

    var currentWeather: WeatherKind {
        if let raw = state.lastNightWeather, let w = WeatherKind(rawValue: raw) {
            return w
        }
        // Pass the season-local night (0...29), not the global night index.
        let localNight = state.nightIndex % 30
        let w = LighthouseKeeperCatalog.weatherFor(localNightIndex: localNight, season: currentSeason, seed: state.rngSeed)
        // Save it
        state.lastNightWeather = w.rawValue
        return w
    }

    var arcStandings: [(ArcKind, Int)] {
        ArcKind.allCases.map { ($0, state.arcScores[$0.rawValue] ?? 0) }
            .sorted { $0.1 > $1.1 }
    }

    var dominantArc: ArcKind {
        return arcStandings.first?.0 ?? .family
    }

    /// Letters whose nightAvailable <= current night and which the player has not yet answered.
    var pendingLetters: [Letter] {
        let answeredIds = Set(state.letterRecords.filter { $0.chosen != nil }.map { $0.letterId })
        return LighthouseKeeperCatalog.letters
            .filter { $0.nightAvailable <= state.nightIndex && !answeredIds.contains($0.id) }
            .sorted { $0.nightAvailable < $1.nightAvailable }
    }

    /// Letters that have already been answered, most recent first.
    var answeredLetters: [(Letter, LetterRecord)] {
        let byId = Dictionary(uniqueKeysWithValues: LighthouseKeeperCatalog.letters.map { ($0.id, $0) })
        return state.letterRecords
            .compactMap { rec -> (Letter, LetterRecord)? in
                if let l = byId[rec.letterId] { return (l, rec) }
                return nil
            }
            .sorted { ($0.1.nightAnswered ?? 0) > ($1.1.nightAnswered ?? 0) }
    }

    // MARK: - Day actions

    func performDayAction(_ action: DayAction) {
        guard state.dayActionsRemaining > 0, state.isDayPhase else { return }
        switch action {
        case .repair:
            // No-op: the UI presents a subsystem picker which calls applyRepair.
            return
        case .inventory:
            // Inventory consumes the slot via this entry point.
            consumeAction()
        case .telegram:
            // Telegram consumes the slot via this entry point.
            consumeAction()
        case .rest:
            state.fatigue = max(0, state.fatigue - 30)
            state.restedBuff = true
            consumeAction()
        case .patrolCave:
            guard state.caveUnlocked else { return }
            performCavePatrol()
            consumeAction()
        case .studyRegistry:
            state.registryStudyBuff = true
            state.logPoints += 2
            consumeAction()
        }
        persist()
    }

    func consumeAction() {
        state.dayActionsRemaining = max(0, state.dayActionsRemaining - 1)
    }

    /// Apply a repair to a single subsystem if parts are available.
    @discardableResult
    func applyRepair(_ kind: SubsystemKind) -> RepairResult {
        // Must be in day phase with an action remaining.
        guard state.isDayPhase, state.dayActionsRemaining > 0 else {
            return .noActions
        }
        // Check parts
        let needed = kind.requiredParts
        for p in needed {
            if (state.partsInventory[p.rawValue] ?? 0) < 1 {
                return .missingPart(p)
            }
        }
        let multiplier = currentWeather.repairCostMultiplier
        let cost = Int(round(Double(needed.count) * 5.0 * multiplier))
        if state.money < cost {
            return .notEnoughMoney(needed: cost)
        }
        // Spend parts and money
        for p in needed {
            state.partsInventory[p.rawValue] = max(0, (state.partsInventory[p.rawValue] ?? 0) - 1)
        }
        state.money -= cost
        // Apply +20...+30 condition
        let gain = 22 + Int.random(in: 0...8)
        let oldCondition = state.subsystemCondition[kind.rawValue] ?? 0
        let newCondition = min(100, oldCondition + gain)
        state.subsystemCondition[kind.rawValue] = newCondition
        state.subsystemRepairCount[kind.rawValue] = (state.subsystemRepairCount[kind.rawValue] ?? 0) + 1
        state.fatigue = min(100, state.fatigue + 8)
        consumeAction()
        checkAchievements()
        persist()
        return .success(gained: gain, cost: cost)
    }

    enum RepairResult {
        case success(gained: Int, cost: Int)
        case missingPart(InventoryPart)
        case notEnoughMoney(needed: Int)
        case noActions
    }

    /// Buy parts at base+weather adjustment.
    @discardableResult
    func buyPart(_ p: InventoryPart, quantity: Int = 1) -> Bool {
        let price = Int(round(Double(p.basePrice * quantity) * currentWeather.repairCostMultiplier))
        if state.money < price { return false }
        state.money -= price
        state.partsInventory[p.rawValue] = (state.partsInventory[p.rawValue] ?? 0) + quantity
        persist()
        checkAchievements()
        return true
    }

    /// Sell a part for half price.
    @discardableResult
    func sellPart(_ p: InventoryPart, quantity: Int = 1) -> Bool {
        let have = state.partsInventory[p.rawValue] ?? 0
        if have < quantity { return false }
        let price = Int((Double(p.basePrice * quantity) * 0.55).rounded())
        state.money += price
        state.partsInventory[p.rawValue] = have - quantity
        persist()
        return true
    }

    // MARK: - Letters

    func answerLetter(_ letter: Letter, choiceId: String) {
        guard let choice = letter.choices.first(where: { $0.id == choiceId }) else { return }
        // Prevent duplicate answers via the navigation stack.
        if state.letterRecords.contains(where: { $0.letterId == letter.id && $0.chosen != nil }) { return }
        for eff in choice.effects {
            applyEffect(eff)
        }
        let rec = LetterRecord(letterId: letter.id, chosen: choiceId, nightAnswered: state.nightIndex)
        state.letterRecords.append(rec)
        checkAchievements()
        persist()
    }

    /// Helper: has this letter already been answered?
    func isLetterAnswered(_ letterId: String) -> Bool {
        return state.letterRecords.contains(where: { $0.letterId == letterId && $0.chosen != nil })
    }

    private func applyEffect(_ eff: LetterEffect) {
        switch eff.kind {
        case .relationship:
            if let c = eff.correspondent {
                let cur = state.relationships[c.rawValue] ?? 0
                state.relationships[c.rawValue] = max(-50, min(100, cur + eff.delta))
            }
        case .arc:
            if let a = eff.arc {
                let cur = state.arcScores[a.rawValue] ?? 0
                state.arcScores[a.rawValue] = max(-50, min(200, cur + eff.delta))
            }
        case .money:
            state.money = max(0, state.money + eff.delta)
        case .fatigue:
            state.fatigue = max(0, min(100, state.fatigue + eff.delta))
        case .reputation:
            state.reputation = max(-50, min(100, state.reputation + eff.delta))
        case .flag:
            if let f = eff.flag { state.flags.insert(f) }
        }
    }

    // MARK: - Night progression

    /// Move to night phase: pre-roll the ship queue for the night.
    func enterNightPhase() {
        guard state.isDayPhase else { return }
        state.isDayPhase = false
        state.hourIndex = 0
        // Force-recompute weather for this night.
        state.lastNightWeather = nil
        let _ = currentWeather  // sets it
        // Pre-roll ships
        let queue = pickShipsForNight()
        state.tonightShipQueue = queue
        state.tonightShipsResolved = []
        state.tonightIdentifiedSoFar = 0
        persist()
    }

    private func pickShipsForNight() -> [String] {
        // Deterministic seed (Hasher is process-salted; do not use here).
        var mix = state.rngSeed &+ UInt64(state.nightIndex) &* 6364136223846793005
        mix = (mix ^ (mix &>> 30)) &* 0xBF58476D1CE4E5B9
        mix = (mix ^ (mix &>> 27)) &* 0x94D049BB133111EB
        mix = mix ^ (mix &>> 31)
        var rng = SplitMix64(seed: mix == 0 ? 0x9E3779B97F4A7C15 : mix)

        let weather = currentWeather
        // Number of ships: weather affects this.
        let base: Int
        switch weather {
        case .clear, .doldrums, .aurora: base = 5
        case .mist, .seaFret, .thunder: base = 4
        case .fog, .snow, .iceRain: base = 3
        case .squall, .gale, .blizzard: base = 2
        }

        // Story ships seeded across seasons
        let season = currentSeason
        var picks: [String] = []
        var picksSet: Set<String> = []
        let storyShipsForSeason: [String]
        switch season {
        case .spring: storyShipsForSeason = ["S001", "S002", "S006"]
        case .summer: storyShipsForSeason = ["S004", "S006", "S016"]
        case .autumn: storyShipsForSeason = ["S003", "S005", "S016"]
        case .winter: storyShipsForSeason = ["S005", "S006", "S004"]
        }
        // 25% chance to include one story ship
        if rng.nextDouble() < 0.25, let pick = storyShipsForSeason.randomElement(using: &rng) {
            picks.append(pick)
            picksSet.insert(pick)
        }
        // Fill the rest with dedupe; bail out if catalog is somehow exhausted.
        let regular = LighthouseKeeperCatalog.ships.filter { !$0.storyShip }
        var safety = 0
        while picks.count < base && safety < 200 {
            safety += 1
            if let pick = regular.randomElement(using: &rng), !picksSet.contains(pick.id) {
                picks.append(pick.id)
                picksSet.insert(pick.id)
            }
        }
        return picks
    }

    /// Advance the night by one tick (hour). Returns true if night ended.
    @discardableResult
    func advanceHour() -> Bool {
        state.hourIndex += 1
        // Degrade subsystems each hour (slightly)
        for k in SubsystemKind.allCases {
            let degradation = k.degradationPerNight / 8.0
            let cur = Double(state.subsystemCondition[k.rawValue] ?? 0)
            let newCond = max(0, cur - degradation)
            state.subsystemCondition[k.rawValue] = Int(newCond.rounded())
        }
        // Fatigue creeps up
        state.fatigue = min(100, state.fatigue + 1)
        // Fuel ticks down
        state.fuel = max(0, state.fuel - 1)

        let ended = state.hourIndex >= 8
        if ended {
            endNight()
        }
        persist()
        return ended
    }

    /// Called when hour reaches 8.
    private func endNight() {
        // Generate journal entry
        let weather = currentWeather
        let logs = state.tonightShipQueue.enumerated().map { (idx, sid) -> JournalEntry.ShipLogEntry in
            JournalEntry.ShipLogEntry(shipId: sid, identified: state.identifiedShips.contains(sid), hour: idx)
        }
        var events: [String] = []
        if state.loggedWeatherThisNight { events.append("Weather correctly logged: \(weather.label).") }
        if state.fatigue >= 80 { events.append("Keeper grew dangerously fatigued.") }
        if state.fuel < 20 { events.append("Fuel critically low.") }
        if state.caveUnlocked == false && state.nightIndex >= 40 {
            state.caveUnlocked = true
            events.append("A cliff-stair grew visible behind the gardener's shed — the cave is now reachable.")
        }
        let summary = composeNightSummary(weather: weather, ships: logs.count, identified: state.tonightIdentifiedSoFar)
        let entry = JournalEntry(
            id: "J\(state.nightIndex)",
            nightIndex: state.nightIndex,
            season: currentSeason,
            weather: weather,
            ships: logs,
            events: events,
            bookmarked: false,
            summary: summary
        )
        state.journal.append(entry)
        // Reward log points based on identifications
        state.logPoints += state.tonightIdentifiedSoFar * 3
        state.money += state.tonightIdentifiedSoFar * 4
        // Reset for next day
        state.nightIndex = min(120, state.nightIndex + 1)
        state.isDayPhase = true
        state.hourIndex = 0
        state.dayActionsRemaining = 3
        state.lastNightWeather = nil
        state.tonightShipQueue = []
        state.tonightShipsResolved = []
        state.tonightIdentifiedSoFar = 0
        state.loggedWeatherThisNight = false
        state.registryStudyBuff = false
        state.restedBuff = false
        checkAchievements()
    }

    private func composeNightSummary(weather: WeatherKind, ships: Int, identified: Int) -> String {
        let frags = [
            "\(weather.label) over the cape. \(ships) ships passed; \(identified) were logged.",
            "\(ships) passes. \(identified) confirmed. Weather: \(weather.label.lowercased()).",
            "Beam steady through the \(weather.label.lowercased()). \(identified) of \(ships) ships entered the registry."
        ]
        // Cosmetic-only flavor text; uses non-seeded randomElement on purpose.
        // The summary is stored verbatim in the journal once chosen, so the
        // outcome is stable for that night even though selection isn't seeded.
        return frags.randomElement() ?? frags[0]
    }

    // MARK: - Ship Identification (called during night)

    func attemptIdentifyShip(_ shipId: String, correctGuess: Bool) -> Bool {
        guard let _ = LighthouseKeeperCatalog.ships.first(where: { $0.id == shipId }) else { return false }
        // Single source of truth: refuse to double-resolve a ship that the
        // timer (or any other path) has already concluded for tonight.
        if state.tonightShipsResolved.contains(shipId) { return false }
        let weather = currentWeather
        // Compute success probability if correctGuess; else fail outright
        if !correctGuess {
            state.tonightShipsResolved.append(shipId)
            persist()
            return false
        }
        // Base success scales with weather difficulty.
        let baseChance = 0.75 / weather.idDifficulty
        let buff = state.registryStudyBuff ? 0.15 : 0
        let restBuff = state.restedBuff ? 0.05 : 0
        let chance = min(0.98, baseChance + buff + restBuff)
        let roll = Double.random(in: 0...1)
        let ok = roll < chance
        state.tonightShipsResolved.append(shipId)
        if ok {
            state.identifiedShips.insert(shipId)
            state.tonightIdentifiedSoFar += 1
            state.totalIdentifiedCount += 1
            state.logPoints += 1
            // Check suspicion flag
            if let ship = LighthouseKeeperCatalog.ships.first(where: { $0.id == shipId }), ship.suspicion != .none {
                state.achievementsEarned.insert(AchievementKind.suspiciousCatch.rawValue)
            }
        }
        checkAchievements()
        persist()
        return ok
    }

    // MARK: - Weather logging

    func logWeather(_ guess: WeatherKind) -> Bool {
        let actual = currentWeather
        let ok = guess == actual
        if ok {
            state.loggedWeathers.insert(actual.rawValue)
            state.weatherMasteryXP += 5
            state.logPoints += 2
            state.money += 2
            state.loggedWeatherThisNight = true
        }
        checkAchievements()
        persist()
        return ok
    }

    // MARK: - Cave Patrol

    func performCavePatrol() {
        // Random artifact attempt: 50% find one new artifact
        let all = CaveArtifact.allCases
        let unfound = all.filter { !state.caveArtifacts.contains($0.rawValue) }
        guard !unfound.isEmpty else {
            state.money += 5
            return
        }
        if Double.random(in: 0...1) < 0.55 {
            if let pick = unfound.randomElement() {
                state.caveArtifacts.insert(pick.rawValue)
                state.lastCaveArtifactId = pick.rawValue
                // Bonus to the arc
                let arc = pick.arc
                let cur = state.arcScores[arc.rawValue] ?? 0
                state.arcScores[arc.rawValue] = cur + 2
            }
        } else {
            state.money += 6
        }
        state.fatigue = min(100, state.fatigue + 12)
        checkAchievements()
    }

    // MARK: - Bookmark

    func toggleBookmark(_ entryId: String) {
        if let idx = state.journal.firstIndex(where: { $0.id == entryId }) {
            let cur = state.journal[idx]
            let newEntry = JournalEntry(
                id: cur.id,
                nightIndex: cur.nightIndex,
                season: cur.season,
                weather: cur.weather,
                ships: cur.ships,
                events: cur.events,
                bookmarked: !cur.bookmarked,
                summary: cur.summary
            )
            state.journal[idx] = newEntry
            persist()
            checkAchievements()
        }
    }

    // MARK: - Achievements

    func checkAchievements() {
        func earn(_ a: AchievementKind) { state.achievementsEarned.insert(a.rawValue) }

        if state.totalIdentifiedCount >= 1 { earn(.firstIdentify) }
        if state.totalIdentifiedCount >= 10 { earn(.tenIdentify) }
        if state.totalIdentifiedCount >= 50 { earn(.fiftyIdentify) }
        if state.totalIdentifiedCount >= 100 { earn(.hundredIdentify) }
        if state.loggedWeathers.contains(WeatherKind.clear.rawValue) { earn(.weatherClear) }
        if state.loggedWeathers.contains(WeatherKind.fog.rawValue) { earn(.weatherFog) }
        if state.loggedWeathers.contains(WeatherKind.blizzard.rawValue) { earn(.weatherBlizzard) }
        if state.loggedWeathers.contains(WeatherKind.aurora.rawValue) { earn(.weatherAurora) }
        if state.loggedWeathers.count == WeatherKind.allCases.count { earn(.weatherAllTwelve) }
        let totalRepairs = state.subsystemRepairCount.values.reduce(0, +)
        if totalRepairs >= 1 { earn(.repairFirst) }
        if totalRepairs >= 10 { earn(.repairTen) }
        if state.subsystemRepairCount.values.allSatisfy({ $0 > 0 }) { earn(.repairAll) }
        if state.subsystemCondition.values.allSatisfy({ $0 >= 90 }) { earn(.allSystemsFull) }
        let answered = state.letterRecords.filter { $0.chosen != nil }.count
        if answered >= 1 { earn(.telegramReply) }
        if answered >= 10 { earn(.telegramTen) }
        if answered >= 30 { earn(.telegramThirty) }
        if state.caveUnlocked { earn(.caveUnlock) }
        if state.caveArtifacts.count >= 5 { earn(.caveFiveArtifacts) }
        if state.caveArtifacts.count == CaveArtifact.allCases.count { earn(.caveAllArtifacts) }
        if state.nightIndex >= 30 { earn(.season2) }
        if state.nightIndex >= 60 { earn(.season3) }
        if state.nightIndex >= 90 { earn(.season4) }
        if state.nightIndex >= 120 { earn(.complete120) }
        let bookmarked = state.journal.filter { $0.bookmarked }.count
        if bookmarked >= 5 { earn(.bookmarkFive) }
        if state.journal.count >= 30 { earn(.journalThirty) }
        let kindsWithMany = state.partsInventory.filter { $0.value >= 8 }.count
        if kindsWithMany >= 5 { earn(.fullPantry) }

        // Arc-end achievements: at or after night 120, any arc that crossed the finale threshold awards.
        // We also award progressively earlier as a courtesy when the player clearly drives an arc home.
        let finaleThreshold = 18
        let lateThreshold = 40
        let nightOK = state.nightIndex >= 120
        for arc in ArcKind.allCases {
            let score = state.arcScores[arc.rawValue] ?? 0
            let crossed = (nightOK && score >= finaleThreshold) || score >= lateThreshold
            if !crossed { continue }
            switch arc {
            case .family: earn(.familyArcEnd)
            case .inspector: earn(.inspectorArcEnd)
            case .wreck: earn(.wreckArcEnd)
            case .smugglers: earn(.smugglerArcEnd)
            case .aurora: earn(.auroraArcEnd)
            }
        }

        // wreckSurvivor: awarded via markStormAid().
        if state.flags.contains("aided_in_storm") {
            earn(.wreckSurvivor)
        }
    }

    /// Records that the keeper guided a vessel through a gale/storm. Awards wreckSurvivor.
    func markStormAid() {
        state.flags.insert("aided_in_storm")
        state.achievementsEarned.insert(AchievementKind.wreckSurvivor.rawValue)
        checkAchievements()
        persist()
    }

    // MARK: - Endings

    enum Ending: String, Codable { case family, inspector, aurora, wreck, smugglers }
    func currentLikelyEnding() -> Ending {
        // Highest arc score becomes the leading ending. All five arcs are considered now.
        var leader: (ArcKind, Int) = (.family, Int.min)
        for arc in ArcKind.allCases {
            let s = state.arcScores[arc.rawValue] ?? 0
            if s > leader.1 { leader = (arc, s) }
        }
        switch leader.0 {
        case .family: return .family
        case .inspector: return .inspector
        case .aurora: return .aurora
        case .wreck: return .wreck
        case .smugglers: return .smugglers
        }
    }
}

/// Lightweight deterministic RNG used for content rolls.
struct SplitMix64: RandomNumberGenerator {
    var seed: UInt64
    mutating func next() -> UInt64 {
        seed = seed &+ 0x9E3779B97F4A7C15
        var z = seed
        z = (z ^ (z &>> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z &>> 27)) &* 0x94D049BB133111EB
        return z ^ (z &>> 31)
    }
    mutating func nextDouble() -> Double {
        let u = next() >> 11
        return Double(u) / Double(1 << 53)
    }
}

extension Array {
    func randomElement<G: RandomNumberGenerator>(using gen: inout G) -> Element? {
        guard !isEmpty else { return nil }
        let i = Int(gen.next() % UInt64(count))
        return self[i]
    }
}
