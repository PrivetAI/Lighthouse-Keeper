import Foundation
import SwiftUI

// MARK: - Season

enum Season: Int, Codable, CaseIterable {
    case spring = 0, summer = 1, autumn = 2, winter = 3
    var label: String {
        switch self {
        case .spring: return "Spring"
        case .summer: return "Summer"
        case .autumn: return "Autumn"
        case .winter: return "Winter"
        }
    }
    var ambientTone: String {
        switch self {
        case .spring: return "Soft rains and shifting fogs. New cargo lanes open."
        case .summer: return "Long evenings, mirror seas. Naval traffic dense."
        case .autumn: return "Gales mount. Cargo schooners scramble before the storms."
        case .winter: return "Ice on the bell. Few brave the cape — and those who do mean it."
        }
    }
    static func of(nightIndex: Int) -> Season {
        // 0...29 spring, 30...59 summer, 60...89 autumn, 90...119 winter
        return Season(rawValue: (nightIndex / 30) % 4) ?? .spring
    }
}

// MARK: - Weather

enum WeatherKind: String, Codable, CaseIterable {
    case clear, mist, fog, squall, gale, snow, blizzard, iceRain, thunder, doldrums, seaFret, aurora

    var label: String {
        switch self {
        case .clear:    return "Clear"
        case .mist:     return "Mist"
        case .fog:      return "Fog"
        case .squall:   return "Squall"
        case .gale:     return "Gale"
        case .snow:     return "Snow"
        case .blizzard: return "Blizzard"
        case .iceRain:  return "Ice Rain"
        case .thunder:  return "Thunder"
        case .doldrums: return "Doldrums"
        case .seaFret:  return "Sea Fret"
        case .aurora:   return "Aurora"
        }
    }

    /// Beam range multiplier (1.0 = full reach).
    var beamRange: Double {
        switch self {
        case .clear: return 1.00
        case .mist: return 0.80
        case .fog: return 0.50
        case .squall: return 0.70
        case .gale: return 0.65
        case .snow: return 0.60
        case .blizzard: return 0.35
        case .iceRain: return 0.55
        case .thunder: return 0.75
        case .doldrums: return 0.95
        case .seaFret: return 0.70
        case .aurora: return 1.05
        }
    }

    /// Ship identification difficulty (1.0 = baseline, higher = harder).
    var idDifficulty: Double {
        switch self {
        case .clear: return 1.00
        case .mist: return 1.25
        case .fog: return 1.80
        case .squall: return 1.35
        case .gale: return 1.40
        case .snow: return 1.55
        case .blizzard: return 2.10
        case .iceRain: return 1.50
        case .thunder: return 1.20
        case .doldrums: return 1.00
        case .seaFret: return 1.45
        case .aurora: return 0.90
        }
    }

    /// Telegram reliability (1.0 = full).
    var telegramReliability: Double {
        switch self {
        case .clear: return 1.00
        case .mist: return 0.95
        case .fog: return 0.85
        case .squall: return 0.70
        case .gale: return 0.55
        case .snow: return 0.80
        case .blizzard: return 0.35
        case .iceRain: return 0.50
        case .thunder: return 0.30
        case .doldrums: return 1.00
        case .seaFret: return 0.85
        case .aurora: return 0.75
        }
    }

    /// Repair cost multiplier (1.0 = baseline).
    var repairCostMultiplier: Double {
        switch self {
        case .clear: return 1.00
        case .mist: return 1.05
        case .fog: return 1.10
        case .squall: return 1.20
        case .gale: return 1.30
        case .snow: return 1.25
        case .blizzard: return 1.50
        case .iceRain: return 1.35
        case .thunder: return 1.25
        case .doldrums: return 0.95
        case .seaFret: return 1.10
        case .aurora: return 0.90
        }
    }

    /// True when the weather is gale-equivalent or worse — used to award wreckSurvivor.
    var isStormy: Bool {
        switch self {
        case .gale, .blizzard, .iceRain, .thunder:
            return true
        default:
            return false
        }
    }

    var note: String {
        switch self {
        case .clear: return "Clean horizon, every star pinned in place."
        case .mist: return "A pearl-haze, thin enough to read by."
        case .fog: return "The cape vanishes. Even the bell sounds muffled."
        case .squall: return "Brief, brutal — over the stair railing in five minutes."
        case .gale: return "Lantern panes rattle in their lead."
        case .snow: return "Flakes large as moths against the lens."
        case .blizzard: return "Whiteout. Walking outside is a guess and a prayer."
        case .iceRain: return "Each drop a tiny chisel."
        case .thunder: return "Sky cracks like an old plate."
        case .doldrums: return "Sea breathes once an hour."
        case .seaFret: return "Salt-mist that creeps in seams."
        case .aurora: return "Green ribbons. The lamp seems half-shy of competing."
        }
    }
}

// MARK: - Ship Registry

struct ShipRegistryEntry: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let kind: ShipSilhouetteKind
    let flag: String       // one of 8 fictional nations
    let tonnage: Int
    let originPort: String
    let captainName: String
    let suspicion: SuspicionFlag
    let storyShip: Bool

    enum SuspicionFlag: String, Codable {
        case none, smuggler, plagueShip, lost, militant, refugees
        var label: String {
            switch self {
            case .none: return "—"
            case .smuggler: return "Smuggling alert"
            case .plagueShip: return "Quarantine"
            case .lost: return "Reported lost"
            case .militant: return "Hostile colors"
            case .refugees: return "Refugee transport"
            }
        }
    }
}

// MARK: - Lighthouse Subsystems

enum SubsystemKind: String, Codable, CaseIterable {
    case lens, gear, lampWick, fuelTank, foghorn, generator, radio, signalMirror

    var label: String {
        switch self {
        case .lens: return "Fresnel Lens"
        case .gear: return "Rotation Gear"
        case .lampWick: return "Lamp Wick"
        case .fuelTank: return "Fuel Tank"
        case .foghorn: return "Foghorn"
        case .generator: return "Generator"
        case .radio: return "Radio Set"
        case .signalMirror: return "Signal Mirror"
        }
    }
    var description: String {
        switch self {
        case .lens: return "Focuses the lamp into a beam. Sensitive to salt fog."
        case .gear: return "Drives the rotation of the optic apparatus."
        case .lampWick: return "Carbon-cotton wick; burns out in hard storms."
        case .fuelTank: return "Reservoir of paraffin and back-up kerosene."
        case .foghorn: return "Diaphragm horn; the cape’s last warning."
        case .generator: return "Backup electric for the radio and inside lighting."
        case .radio: return "Brass-and-vacuum-tube set. Squeaks in thunder."
        case .signalMirror: return "Polished disc for daytime signaling to harbor."
        }
    }
    var degradationPerNight: Double {
        switch self {
        case .lens: return 1.0
        case .gear: return 1.4
        case .lampWick: return 1.8
        case .fuelTank: return 1.1
        case .foghorn: return 0.8
        case .generator: return 1.2
        case .radio: return 0.9
        case .signalMirror: return 0.6
        }
    }
    var requiredParts: [InventoryPart] {
        switch self {
        case .lens: return [.cleaningSolvent, .leadCame]
        case .gear: return [.brassGear, .oilCan, .axleGrease]
        case .lampWick: return [.cottonWick, .alcohol]
        case .fuelTank: return [.paraffin, .copperFitting]
        case .foghorn: return [.diaphragm, .brassGear]
        case .generator: return [.copperWire, .copperFitting, .glassFuse]
        case .radio: return [.vacuumTube, .copperWire, .glassFuse]
        case .signalMirror: return [.cleaningSolvent, .leadCame]
        }
    }
}

// MARK: - Inventory Parts

enum InventoryPart: String, Codable, CaseIterable {
    case cottonWick, paraffin, alcohol, copperWire, copperFitting, brassGear,
         oilCan, axleGrease, vacuumTube, glassFuse, leadCame, cleaningSolvent,
         diaphragm, sparkPlug, sealingWax

    var label: String {
        switch self {
        case .cottonWick: return "Cotton Wick"
        case .paraffin: return "Paraffin"
        case .alcohol: return "Spirit Alcohol"
        case .copperWire: return "Copper Wire"
        case .copperFitting: return "Copper Fitting"
        case .brassGear: return "Brass Gear"
        case .oilCan: return "Oil Can"
        case .axleGrease: return "Axle Grease"
        case .vacuumTube: return "Vacuum Tube"
        case .glassFuse: return "Glass Fuse"
        case .leadCame: return "Lead Came"
        case .cleaningSolvent: return "Cleaning Solvent"
        case .diaphragm: return "Foghorn Diaphragm"
        case .sparkPlug: return "Spark Plug"
        case .sealingWax: return "Sealing Wax"
        }
    }
    var basePrice: Int {
        switch self {
        case .cottonWick: return 8
        case .paraffin: return 14
        case .alcohol: return 10
        case .copperWire: return 12
        case .copperFitting: return 18
        case .brassGear: return 22
        case .oilCan: return 9
        case .axleGrease: return 7
        case .vacuumTube: return 28
        case .glassFuse: return 11
        case .leadCame: return 16
        case .cleaningSolvent: return 6
        case .diaphragm: return 24
        case .sparkPlug: return 13
        case .sealingWax: return 5
        }
    }
}

// MARK: - NPCs / Letters

enum CorrespondentKind: String, Codable, CaseIterable {
    case wife, daughter, brother, harborMaster, navalInspector, oldFriend, society, stranger

    var displayName: String {
        switch self {
        case .wife: return "Mira (your wife)"
        case .daughter: return "Calla (your daughter)"
        case .brother: return "Olen (your brother)"
        case .harborMaster: return "Harbor-Master Petr Vaal"
        case .navalInspector: return "Naval Inspector Ravna Hess"
        case .oldFriend: return "Tobias (old friend)"
        case .society: return "Lighthouse Society"
        case .stranger: return "Unsigned"
        }
    }
    var arc: ArcKind {
        switch self {
        case .wife, .daughter: return .family
        case .brother: return .family
        case .harborMaster: return .smugglers
        case .navalInspector: return .inspector
        case .oldFriend: return .wreck
        case .society: return .inspector
        case .stranger: return .aurora
        }
    }
}

// MARK: - Arcs

enum ArcKind: String, Codable, CaseIterable {
    case family, inspector, wreck, smugglers, aurora

    var label: String {
        switch self {
        case .family: return "Hearth Light"
        case .inspector: return "The Inspector’s Ledger"
        case .wreck: return "The Sundered Hull"
        case .smugglers: return "Low Tide Cargo"
        case .aurora: return "Aurora’s Margin"
        }
    }
    var summary: String {
        switch self {
        case .family:
            return "Letters from Mira, Calla, and Olen pull the keeper inland. The choice between watch and family shapes every reply."
        case .inspector:
            return "Inspector Hess is auditing every cape lighthouse. Procedure and pride collide; the Society watches both."
        case .wreck:
            return "An old friend writes about a hull torn under the cape decades ago. The wreck is still down there. So is what it carried."
        case .smugglers:
            return "The Harbor-Master suspects a quiet trade is using your beam against you. To unlight is to disobey. To light is to assist."
        case .aurora:
            return "Strange auroras precede strange artifacts. A stranger writes in the same ink as the cliff-cave walls."
        }
    }
}

// MARK: - Letter & Choices

struct LetterChoice: Identifiable, Codable {
    let id: String
    let text: String
    let effects: [LetterEffect]
}

struct LetterEffect: Codable {
    enum Kind: String, Codable {
        case relationship   // affects one correspondent by `delta`
        case arc            // shifts an arc score by `delta`
        case money
        case fatigue
        case reputation
        case flag           // sets a string flag
    }
    let kind: Kind
    let arc: ArcKind?
    let correspondent: CorrespondentKind?
    let delta: Int
    let flag: String?

    init(kind: Kind, arc: ArcKind? = nil, correspondent: CorrespondentKind? = nil, delta: Int = 0, flag: String? = nil) {
        self.kind = kind
        self.arc = arc
        self.correspondent = correspondent
        self.delta = delta
        self.flag = flag
    }
}

struct Letter: Identifiable, Codable {
    let id: String
    let nightAvailable: Int
    let correspondent: CorrespondentKind
    let title: String
    let body: String
    let choices: [LetterChoice]
}

struct LetterRecord: Codable {
    let letterId: String
    let chosen: String?           // choice id, nil = unread
    let nightAnswered: Int?
}

// MARK: - Journal

struct JournalEntry: Identifiable, Codable {
    let id: String
    let nightIndex: Int
    let season: Season
    let weather: WeatherKind
    let ships: [ShipLogEntry]
    let events: [String]
    let bookmarked: Bool
    let summary: String

    struct ShipLogEntry: Codable, Hashable {
        let shipId: String
        let identified: Bool
        let hour: Int
    }
}

// MARK: - Achievements

enum AchievementKind: String, Codable, CaseIterable {
    case firstIdentify, tenIdentify, fiftyIdentify, hundredIdentify
    case weatherClear, weatherFog, weatherBlizzard, weatherAurora, weatherAllTwelve
    case repairFirst, repairTen, repairAll, allSystemsFull
    case telegramReply, telegramTen, telegramThirty
    case caveUnlock, caveFiveArtifacts, caveAllArtifacts
    case familyArcEnd, inspectorArcEnd, wreckArcEnd, smugglerArcEnd, auroraArcEnd
    case season2, season3, season4, complete120
    case fullPantry, bookmarkFive, journalThirty, suspiciousCatch, wreckSurvivor

    var label: String {
        switch self {
        case .firstIdentify: return "First Identification"
        case .tenIdentify: return "Watchful (10 IDs)"
        case .fiftyIdentify: return "Lensman (50 IDs)"
        case .hundredIdentify: return "Cape Veteran (100 IDs)"
        case .weatherClear: return "Star Pin"
        case .weatherFog: return "Through the Pearl"
        case .weatherBlizzard: return "Whiteout Witness"
        case .weatherAurora: return "Auroral Eye"
        case .weatherAllTwelve: return "Twelve Skies"
        case .repairFirst: return "First Wrench"
        case .repairTen: return "Steady Hand"
        case .repairAll: return "All Systems"
        case .allSystemsFull: return "Tower in Tune"
        case .telegramReply: return "First Reply"
        case .telegramTen: return "Faithful Correspondent"
        case .telegramThirty: return "Letter-keeper"
        case .caveUnlock: return "Stair to the Tide"
        case .caveFiveArtifacts: return "Tidewrack"
        case .caveAllArtifacts: return "The Cave Inventory"
        case .familyArcEnd: return "Hearth Light (arc end)"
        case .inspectorArcEnd: return "The Ledger Closed"
        case .wreckArcEnd: return "The Hull Remembered"
        case .smugglerArcEnd: return "Low Tide Reckoning"
        case .auroraArcEnd: return "Aurora’s Margin"
        case .season2: return "Through Spring"
        case .season3: return "Through Summer"
        case .season4: return "Through Autumn"
        case .complete120: return "120 Nights"
        case .fullPantry: return "Full Pantry"
        case .bookmarkFive: return "Marker of Pages"
        case .journalThirty: return "Thirty Logs"
        case .suspiciousCatch: return "Suspicion Confirmed"
        case .wreckSurvivor: return "Rescuer in the Storm"
        }
    }

    var hint: String {
        switch self {
        case .firstIdentify: return "Identify your first passing ship."
        case .tenIdentify: return "Identify 10 ships."
        case .fiftyIdentify: return "Identify 50 ships."
        case .hundredIdentify: return "Identify 100 ships."
        case .weatherClear: return "Correctly log a clear-night sky."
        case .weatherFog: return "Correctly log fog."
        case .weatherBlizzard: return "Correctly log a blizzard."
        case .weatherAurora: return "Correctly log an aurora."
        case .weatherAllTwelve: return "Log every weather kind at least once."
        case .repairFirst: return "Complete your first repair."
        case .repairTen: return "Complete 10 repairs."
        case .repairAll: return "Repair every subsystem at least once."
        case .allSystemsFull: return "All 8 subsystems at 90+ condition simultaneously."
        case .telegramReply: return "Send your first telegram reply."
        case .telegramTen: return "Reply to 10 letters."
        case .telegramThirty: return "Reply to 30 letters."
        case .caveUnlock: return "Unlock the cliff cave."
        case .caveFiveArtifacts: return "Find 5 artifacts in the cave."
        case .caveAllArtifacts: return "Find all 20 cave artifacts."
        case .familyArcEnd: return "Reach the Family arc finale."
        case .inspectorArcEnd: return "Reach the Inspector arc finale."
        case .wreckArcEnd: return "Reach the Wreck arc finale."
        case .smugglerArcEnd: return "Reach the Smuggler arc finale."
        case .auroraArcEnd: return "Reach the Aurora arc finale."
        case .season2: return "Begin Summer."
        case .season3: return "Begin Autumn."
        case .season4: return "Begin Winter."
        case .complete120: return "Survive all 120 nights."
        case .fullPantry: return "Hold 8+ parts of 5 different kinds."
        case .bookmarkFive: return "Bookmark 5 journal entries."
        case .journalThirty: return "Accumulate 30 journal entries."
        case .suspiciousCatch: return "Identify a ship while its suspicion is active."
        case .wreckSurvivor: return "Aid a vessel during a gale or worse."
        }
    }
}

// MARK: - Cave Artifacts (20)

enum CaveArtifact: String, Codable, CaseIterable {
    case glassFloat, brassDolphin, sailorsKnot, ironLockBox, saltcherryAmber, bottleScroll,
         crackedBell, copperCoin, etchedTooth, charredJournal,
         signalLantern, leadShot, embroideredHandkerchief, hempCordage, polishedAgate,
         oilskinPouch, anchorChainLink, naturalistsSketch, smuggledCargoTag, auroralShard

    var label: String {
        switch self {
        case .glassFloat: return "Green Glass Float"
        case .brassDolphin: return "Brass Dolphin Charm"
        case .sailorsKnot: return "Sailor's Monkey Fist"
        case .ironLockBox: return "Rusted Iron Lockbox"
        case .saltcherryAmber: return "Saltcherry Amber"
        case .bottleScroll: return "Bottle with Scroll"
        case .crackedBell: return "Cracked Ship's Bell"
        case .copperCoin: return "Worn Copper Coin"
        case .etchedTooth: return "Etched Whale Tooth"
        case .charredJournal: return "Charred Keeper's Journal"
        case .signalLantern: return "Half-Burnt Signal Lantern"
        case .leadShot: return "Lead Pistol Shot"
        case .embroideredHandkerchief: return "Embroidered Handkerchief"
        case .hempCordage: return "Tarred Hemp Cordage"
        case .polishedAgate: return "Polished Sea Agate"
        case .oilskinPouch: return "Oilskin Pouch"
        case .anchorChainLink: return "Single Anchor Chain Link"
        case .naturalistsSketch: return "Naturalist's Folded Sketch"
        case .smuggledCargoTag: return "Smuggled-Cargo Lead Tag"
        case .auroralShard: return "Auroral Shard"
        }
    }

    var lore: String {
        switch self {
        case .glassFloat: return "A fisherman's float, drifted from far north — Norvalga, perhaps. The glass is full of trapped silver."
        case .brassDolphin: return "Worn smooth on one side, sharp on the other. A captain's charm."
        case .sailorsKnot: return "A monkey-fist as round as your thumb. Hand-tied; well-loved."
        case .ironLockBox: return "Locked. The metal of the keyhole is filled with sea-bloom."
        case .saltcherryAmber: return "A bead of amber the color of stewed cherries. Holds an insect from a forgotten coast."
        case .bottleScroll: return "Glass bottle. Inside: a slip of vellum begging for help, dated decades ago."
        case .crackedBell: return "Brass bell. A name half-hammered out. The cape recognized it once."
        case .copperCoin: return "Maremont mintmark. The face is a fish with a crown."
        case .etchedTooth: return "Whale tooth scratched with a map: cape, lighthouse, X far below."
        case .charredJournal: return "A keeper's journal a century older than yours. Pages survive."
        case .signalLantern: return "Half-melted. Its glass still holds a smear of green."
        case .leadShot: return "Soft, weighty. The dimple of a barrel."
        case .embroideredHandkerchief: return "Initials M.V. The thread is silver and salt-stiff."
        case .hempCordage: return "Long enough to lower a man. Old, but holds."
        case .polishedAgate: return "Striped agate, smooth as a tongue."
        case .oilskinPouch: return "Inside: a pinch of dried herb that smells like the sun."
        case .anchorChainLink: return "Just one link. It must have come from a chain miles long."
        case .naturalistsSketch: return "An illustrated bird — never recorded in your registry."
        case .smuggledCargoTag: return "Lead tag stamped with codes. Matches the Harbor-Master's suspicions."
        case .auroralShard: return "A sliver of mineral that glows faintly green at the edges."
        }
    }

    var arc: ArcKind {
        switch self {
        case .ironLockBox, .crackedBell, .anchorChainLink, .charredJournal, .signalLantern,
             .leadShot, .embroideredHandkerchief, .hempCordage, .bottleScroll:
            return .wreck
        case .smuggledCargoTag, .copperCoin, .oilskinPouch, .saltcherryAmber:
            return .smugglers
        case .auroralShard, .naturalistsSketch, .etchedTooth, .glassFloat, .polishedAgate:
            return .aurora
        case .brassDolphin, .sailorsKnot:
            return .family
        }
    }
}

// MARK: - Day Action

enum DayAction: String, Codable, CaseIterable {
    case repair, inventory, telegram, rest, patrolCave, studyRegistry

    var label: String {
        switch self {
        case .repair: return "Repair Subsystem"
        case .inventory: return "Manage Inventory"
        case .telegram: return "Telegrams"
        case .rest: return "Rest"
        case .patrolCave: return "Patrol Cave"
        case .studyRegistry: return "Study Registry"
        }
    }
    var description: String {
        switch self {
        case .repair: return "Bring one subsystem closer to perfect. Costs parts."
        case .inventory: return "Buy or sell parts at harbor prices."
        case .telegram: return "Read and reply to your letters."
        case .rest: return "Recover fatigue. Slower XP earn this night."
        case .patrolCave: return "Step down the cliff-stair at low tide. Unlocks at night 40."
        case .studyRegistry: return "Improves identification chance for tonight."
        }
    }
}
