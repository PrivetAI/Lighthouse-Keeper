import Foundation

/// All static, hand-authored content lives here so it can be referenced from
/// anywhere without touching LighthouseKeeperStore.
enum LighthouseKeeperCatalog {

    // MARK: - Nations

    static let nations: [String] = [
        "Halverin", "Kerstadt", "Norvalga", "Briath",
        "Vossengard", "Maremont", "Tussolen", "Olstrand"
    ]

    static let originPorts: [String] = [
        "Old Halverin", "Bremgate", "Cape Verlin", "Vossen Reach",
        "Maremont Quay", "Tussolen Locks", "Olstrand Brink", "Kerstadt-on-Sound",
        "Norvalga Pole", "Briath Strand", "Linden Inlet", "Sable Anchorage",
        "Greysound", "Hookholm", "Petryn Wharf"
    ]

    // MARK: - Ship Registry (30+)

    static let ships: [ShipRegistryEntry] = [
        // --- Story ships (6) - recur across seasons
        ShipRegistryEntry(id: "S001", name: "The Margrave's Wake", kind: .passenger, flag: "Halverin", tonnage: 3400, originPort: "Old Halverin", captainName: "Captain Lirien Vossbach", suspicion: .none, storyShip: true),
        ShipRegistryEntry(id: "S002", name: "Cape Light", kind: .sail, flag: "Maremont", tonnage: 220, originPort: "Maremont Quay", captainName: "Captain Iona Brem", suspicion: .none, storyShip: true),
        ShipRegistryEntry(id: "S003", name: "Iron Pelican", kind: .cargo, flag: "Kerstadt", tonnage: 5600, originPort: "Kerstadt-on-Sound", captainName: "Captain Garth Velm", suspicion: .smuggler, storyShip: true),
        ShipRegistryEntry(id: "S004", name: "HMS Resolve", kind: .military, flag: "Vossengard", tonnage: 8200, originPort: "Vossen Reach", captainName: "Commander Ravna Hess", suspicion: .none, storyShip: true),
        ShipRegistryEntry(id: "S005", name: "The Sundered Hull", kind: .derelict, flag: "Olstrand", tonnage: 1100, originPort: "Olstrand Brink", captainName: "Captain Tobias Reed (presumed lost)", suspicion: .lost, storyShip: true),
        ShipRegistryEntry(id: "S006", name: "The Aurora Margin", kind: .yacht, flag: "Briath", tonnage: 460, originPort: "Briath Strand", captainName: "Captain Unknown", suspicion: .none, storyShip: true),

        // --- Cargo
        ShipRegistryEntry(id: "S007", name: "Hookholm Trader", kind: .cargo, flag: "Halverin", tonnage: 4800, originPort: "Hookholm", captainName: "Captain Maron Velm", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S008", name: "Salt Hoist", kind: .cargo, flag: "Norvalga", tonnage: 3100, originPort: "Norvalga Pole", captainName: "Captain Sten Halv", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S009", name: "The Pelt", kind: .cargo, flag: "Tussolen", tonnage: 2700, originPort: "Tussolen Locks", captainName: "Captain Halrun Brem", suspicion: .smuggler, storyShip: false),
        ShipRegistryEntry(id: "S010", name: "Verlin Star", kind: .cargo, flag: "Maremont", tonnage: 4200, originPort: "Cape Verlin", captainName: "Captain Itta Vossbach", suspicion: .none, storyShip: false),

        // --- Passenger
        ShipRegistryEntry(id: "S011", name: "Lady Bremgate", kind: .passenger, flag: "Kerstadt", tonnage: 5200, originPort: "Bremgate", captainName: "Captain Olda Hess", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S012", name: "The Wandering Salt", kind: .passenger, flag: "Briath", tonnage: 4100, originPort: "Briath Strand", captainName: "Captain Lirien Pol", suspicion: .refugees, storyShip: false),
        ShipRegistryEntry(id: "S013", name: "Margrave's Pride", kind: .passenger, flag: "Halverin", tonnage: 3900, originPort: "Old Halverin", captainName: "Captain Vorel Beck", suspicion: .none, storyShip: false),

        // --- Fishing
        ShipRegistryEntry(id: "S014", name: "Mira's Hope", kind: .fishing, flag: "Maremont", tonnage: 180, originPort: "Maremont Quay", captainName: "Captain Roen Brink", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S015", name: "Petryn Bell", kind: .fishing, flag: "Tussolen", tonnage: 210, originPort: "Petryn Wharf", captainName: "Captain Halsa Velm", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S016", name: "Cape Wren", kind: .fishing, flag: "Olstrand", tonnage: 160, originPort: "Olstrand Brink", captainName: "Captain Olen (your brother)", suspicion: .none, storyShip: true),
        ShipRegistryEntry(id: "S017", name: "Greysound Boy", kind: .fishing, flag: "Norvalga", tonnage: 140, originPort: "Greysound", captainName: "Captain Tursen Halv", suspicion: .none, storyShip: false),

        // --- Military
        ShipRegistryEntry(id: "S018", name: "HMS Lantern", kind: .military, flag: "Vossengard", tonnage: 7400, originPort: "Vossen Reach", captainName: "Lieutenant Marbeck Pol", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S019", name: "Kerstadt Sword", kind: .military, flag: "Kerstadt", tonnage: 6900, originPort: "Kerstadt-on-Sound", captainName: "Commodore Anur Vossbach", suspicion: .militant, storyShip: false),

        // --- Derelict
        ShipRegistryEntry(id: "S020", name: "The Drift", kind: .derelict, flag: "Briath", tonnage: 800, originPort: "Briath Strand", captainName: "Captain Unknown", suspicion: .lost, storyShip: false),
        ShipRegistryEntry(id: "S021", name: "Last Brigantine", kind: .derelict, flag: "Olstrand", tonnage: 950, originPort: "Olstrand Brink", captainName: "Captain Unknown", suspicion: .lost, storyShip: false),

        // --- Sail / Yacht / Steamer / Tanker / Ferry
        ShipRegistryEntry(id: "S022", name: "Cape Saltwing", kind: .sail, flag: "Maremont", tonnage: 280, originPort: "Maremont Quay", captainName: "Captain Vilen Brem", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S023", name: "Bright Lyric", kind: .sail, flag: "Halverin", tonnage: 320, originPort: "Old Halverin", captainName: "Captain Roen Hess", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S024", name: "Briath Drift", kind: .yacht, flag: "Briath", tonnage: 410, originPort: "Briath Strand", captainName: "Captain Calla Olstrand", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S025", name: "Steamer Voss", kind: .steamer, flag: "Vossengard", tonnage: 3300, originPort: "Vossen Reach", captainName: "Captain Petr Vaal", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S026", name: "Old Kettle", kind: .steamer, flag: "Halverin", tonnage: 2800, originPort: "Old Halverin", captainName: "Captain Tobias Beck", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S027", name: "Maremont Tanker", kind: .tanker, flag: "Maremont", tonnage: 9100, originPort: "Maremont Quay", captainName: "Captain Vorel Velm", suspicion: .smuggler, storyShip: false),
        ShipRegistryEntry(id: "S028", name: "Verlin Black", kind: .tanker, flag: "Olstrand", tonnage: 9400, originPort: "Cape Verlin", captainName: "Captain Halsa Pol", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S029", name: "Cape Ferry", kind: .ferry, flag: "Briath", tonnage: 1600, originPort: "Briath Strand", captainName: "Captain Itta Brem", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S030", name: "Tussolen Ferry", kind: .ferry, flag: "Tussolen", tonnage: 1450, originPort: "Tussolen Locks", captainName: "Captain Sten Reed", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S031", name: "Norvalga Express", kind: .ferry, flag: "Norvalga", tonnage: 1700, originPort: "Norvalga Pole", captainName: "Captain Roen Vossbach", suspicion: .none, storyShip: false),
        ShipRegistryEntry(id: "S032", name: "Olstrand Tide", kind: .fishing, flag: "Olstrand", tonnage: 175, originPort: "Olstrand Brink", captainName: "Captain Halrun Reed", suspicion: .plagueShip, storyShip: false)
    ]

    // MARK: - Weather distribution per season

    static func weatherDistribution(for season: Season) -> [WeatherKind: Int] {
        switch season {
        case .spring:
            return [.clear: 4, .mist: 4, .fog: 3, .squall: 3, .thunder: 2, .seaFret: 2, .doldrums: 1, .gale: 1]
        case .summer:
            return [.clear: 6, .mist: 2, .fog: 1, .doldrums: 3, .thunder: 2, .seaFret: 1, .aurora: 1, .squall: 1]
        case .autumn:
            return [.clear: 2, .mist: 2, .fog: 3, .squall: 3, .gale: 4, .thunder: 3, .seaFret: 2, .iceRain: 1]
        case .winter:
            return [.clear: 1, .fog: 2, .snow: 4, .blizzard: 3, .iceRain: 3, .gale: 3, .seaFret: 1, .aurora: 3]
        }
    }

    /// Pick weather for a specific (season, night). Deterministic from seeds.
    /// Uses a stable mix instead of `Hasher` (Hasher is process-salted on Swift; non-deterministic across launches).
    /// `localNightIndex` is the 0-indexed night within the season (0...29).
    static func weatherFor(localNightIndex: Int, season: Season, seed: UInt64) -> WeatherKind {
        let dist = weatherDistribution(for: season)
        let total = dist.values.reduce(0, +)
        // Stable mix using a SplitMix64-style constant.
        var mix = seed &+ UInt64(localNightIndex) &* 6364136223846793005
        mix = mix &+ UInt64(season.rawValue + 1) &* 1442695040888963407
        // Final scramble so adjacent values disperse.
        mix = (mix ^ (mix &>> 30)) &* 0xBF58476D1CE4E5B9
        mix = (mix ^ (mix &>> 27)) &* 0x94D049BB133111EB
        mix = mix ^ (mix &>> 31)
        var roll = Int(mix % UInt64(total))
        for (kind, w) in dist.sorted(by: { $0.key.rawValue < $1.key.rawValue }) {
            if roll < w { return kind }
            roll -= w
        }
        return .clear
    }

    // MARK: - Letters (60+)
    // Authored so they're triggered by night index. We split across the 5 arcs and 8 correspondents.

    static let letters: [Letter] = LetterCatalog.all
}

// Splitting the letter list off so the catalog file stays readable.
enum LetterCatalog {

    static let all: [Letter] = familyLetters + inspectorLetters + wreckLetters + smugglerLetters + auroraLetters

    // FAMILY ARC (wife + daughter + brother) — 18 letters
    static let familyLetters: [Letter] = [
        Letter(
            id: "L_FAM_001", nightAvailable: 2, correspondent: .wife,
            title: "First Storm",
            body: "Dearest, the lamp in the kitchen guttered for an hour tonight, and Calla asked if you’d be home before the next moon. I told her your lamp is harder to put out than ours. Write soon, even one line. — Mira",
            choices: [
                LetterChoice(id: "C1", text: "Write a tender, careful line.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 4),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Write practical: weather, stores, next mail packet.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 1),
                    LetterEffect(kind: .arc, arc: .family, delta: 1)
                ]),
                LetterChoice(id: "C3", text: "Don't reply this round.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: -3),
                    LetterEffect(kind: .arc, arc: .family, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_002", nightAvailable: 6, correspondent: .daughter,
            title: "I drew the tower",
            body: "Papa I drew the tower with eight stripes because I forgot how many. Also Mira (I call her Mira when she is not listening) bought a fish that was the size of the table. Is that allowed? Yours, Calla, age nine.",
            choices: [
                LetterChoice(id: "C1", text: "Send back a careful pencil sketch of the real tower.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Promise to count the stripes when you next dust the gallery.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 3),
                    LetterEffect(kind: .arc, arc: .family, delta: 2)
                ]),
                LetterChoice(id: "C3", text: "Tell her fish that size are usually polite.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 4)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_003", nightAvailable: 9, correspondent: .brother,
            title: "Cape Wren is sailing",
            body: "Brother — taking the Cape Wren south this fortnight for hake. If the gale season is early, you'll see my running lights off the cape on the 14th. Don't tell Mira; I told her I'm in port. — Olen",
            choices: [
                LetterChoice(id: "C1", text: "Promise to keep the secret. Light him through.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 2),
                    LetterEffect(kind: .flag, flag: "knows_olen_run")
                ]),
                LetterChoice(id: "C2", text: "Tell him not to come this season. Storms are bad.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: -2),
                    LetterEffect(kind: .arc, arc: .family, delta: 1)
                ]),
                LetterChoice(id: "C3", text: "Send Mira a separate note: 'Olen is fishing south.'", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 2),
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: -4)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_004", nightAvailable: 14, correspondent: .wife,
            title: "Calla's tooth",
            body: "She lost a tooth at last. Put it under a stone in the garden because the pillow trick made her suspicious. We are well. I am cleaning the lamp in your study, the one shaped like a swan. — M.",
            choices: [
                LetterChoice(id: "C1", text: "Send a small banknote toward a present.", effects: [
                    LetterEffect(kind: .money, delta: -10),
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 3),
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "Just reply: keep the tooth for me to see.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 3),
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 4),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ]),
                LetterChoice(id: "C3", text: "Be brisk. Lamp glass requires solvent.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_005", nightAvailable: 21, correspondent: .daughter,
            title: "Question",
            body: "Papa is the sea bigger than the sky. I told Mavri at school that the sea is heavier but Mavri said no. Please write back with which is correct.",
            choices: [
                LetterChoice(id: "C1", text: "Sea is heavier; sky is wider.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 4),
                    LetterEffect(kind: .arc, arc: .family, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "It depends what you weigh and what you measure.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ]),
                LetterChoice(id: "C3", text: "Mavri is correct. Be a good loser.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: -1)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_006", nightAvailable: 28, correspondent: .wife,
            title: "Furnace",
            body: "The furnace died. I had Velm-from-down-the-lane in to look at it; he says it’s the pump. Says fifteen marks. I will sort it; do not worry. — Mira",
            choices: [
                LetterChoice(id: "C1", text: "Wire fifteen marks immediately.", effects: [
                    LetterEffect(kind: .money, delta: -15),
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 4)
                ]),
                LetterChoice(id: "C2", text: "Wire twenty marks: insist she let Velm do a full check.", effects: [
                    LetterEffect(kind: .money, delta: -20),
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 6),
                    LetterEffect(kind: .arc, arc: .family, delta: 2)
                ]),
                LetterChoice(id: "C3", text: "Tell her to wait until you next come home; you'll fix it.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_007", nightAvailable: 35, correspondent: .brother,
            title: "Cape Wren caught hake",
            body: "We caught hake the size of nightmares. Boat is fine; me too. Saw your beam on the 22nd — steady as a heart. Pay you back when the load sells. — O.",
            choices: [
                LetterChoice(id: "C1", text: "Tell him no payment necessary. Be careful next run.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "Ask for a share of the hake instead.", effects: [
                    LetterEffect(kind: .money, delta: 8),
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 2)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_008", nightAvailable: 42, correspondent: .wife,
            title: "Winter Plans",
            body: "Calla is asking when you’ll come home for the winter holiday. I have not promised her anything. Tell me what to tell her. — M.",
            choices: [
                LetterChoice(id: "C1", text: "Promise: yes, I'll come for the winter quarter.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 5),
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 6),
                    LetterEffect(kind: .flag, flag: "promised_winter_home")
                ]),
                LetterChoice(id: "C2", text: "Hedge: weather and the cape decide.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: -1),
                    LetterEffect(kind: .arc, arc: .family, delta: -2)
                ]),
                LetterChoice(id: "C3", text: "Refuse — the cape needs me through the storms.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: -4),
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: -3),
                    LetterEffect(kind: .arc, arc: .family, delta: -4),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 2)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_009", nightAvailable: 51, correspondent: .daughter,
            title: "I want to be a keeper",
            body: "Papa I want to be a lighthouse keeper too. Mira says I should be a teacher. Tell her keepers are also teachers — they teach the boats. Yes? — C.",
            choices: [
                LetterChoice(id: "C1", text: "Tell her yes — keepers teach boats and the dark.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Tell her teaching is bigger work than the lamp.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 1),
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_010", nightAvailable: 58, correspondent: .brother,
            title: "Trouble at quayside",
            body: "Brother — Harbor-Master pulled me aside about cargo manifests. Don't know what he's chasing. Keep your beam on schedule on the 60th-65th. — O.",
            choices: [
                LetterChoice(id: "C1", text: "Promise the beam stays on schedule.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 4),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Ask him what cargo. Bluntly.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: -2),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -2),
                    LetterEffect(kind: .flag, flag: "asked_olen_cargo")
                ]),
                LetterChoice(id: "C3", text: "Send the letter on to Harbor-Master Vaal.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: -8),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: -6)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_011", nightAvailable: 66, correspondent: .wife,
            title: "Frost",
            body: "First frost was last night. Calla put salt in her boots because Mavri told her witches don't like it. I told her witches don't like wet feet. — Mira",
            choices: [
                LetterChoice(id: "C1", text: "Reply gently. Send a small amber bead.", effects: [
                    LetterEffect(kind: .money, delta: -5),
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 4),
                    LetterEffect(kind: .arc, arc: .family, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "Reply with the weather forecast.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: -1)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_012", nightAvailable: 75, correspondent: .daughter,
            title: "Will you teach me morse",
            body: "Papa, Mavri's father teaches him morse. Will you teach me? In your next letter put a word in dots.",
            choices: [
                LetterChoice(id: "C1", text: "Send the word LIGHT in dots and dashes.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Send the word CALLA in dots and dashes.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 6),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_013", nightAvailable: 84, correspondent: .brother,
            title: "I'm done",
            body: "Brother — I'm hanging up the boat. Got an offer from a quayside agent for the Cape Wren. If it goes through I'll be inland by spring. Mira will know first; I'll write her tomorrow. — O.",
            choices: [
                LetterChoice(id: "C1", text: "Tell him good. He's earned dry feet.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 4)
                ]),
                LetterChoice(id: "C2", text: "Ask if the agent is from Kerstadt. Be specific.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 2),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 3),
                    LetterEffect(kind: .flag, flag: "knows_kerstadt_agent")
                ])
            ]
        ),
        Letter(
            id: "L_FAM_014", nightAvailable: 92, correspondent: .wife,
            title: "Winter holiday",
            body: "It is winter. Are you coming? — Mira (one line)",
            choices: [
                LetterChoice(id: "C1", text: "Yes — coming on the 100th, three days only.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 6),
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 6),
                    LetterEffect(kind: .arc, arc: .family, delta: 6),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -3),
                    LetterEffect(kind: .flag, flag: "winter_trip_made")
                ]),
                LetterChoice(id: "C2", text: "I can’t. The cape is dark with weather.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: -5),
                    LetterEffect(kind: .arc, arc: .family, delta: -6),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_015", nightAvailable: 101, correspondent: .daughter,
            title: "Stripes",
            body: "Papa — I drew the tower right this time. Twelve stripes. Mavri said too many. I told him you would know.",
            choices: [
                LetterChoice(id: "C1", text: "Tell her twelve stripes is exactly right.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 4),
                    LetterEffect(kind: .arc, arc: .family, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "Tell her: it's seven, but twelve is more beautiful.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_016", nightAvailable: 108, correspondent: .wife,
            title: "Spring soon",
            body: "I had a dream the cape was on fire. Tell me it isn't. Write back tonight. — M.",
            choices: [
                LetterChoice(id: "C1", text: "Write back: the cape is cold and quiet. Sleep.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Tell her about the aurora last week.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 3),
                    LetterEffect(kind: .arc, arc: .aurora, delta: 2)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_017", nightAvailable: 114, correspondent: .brother,
            title: "Selling Cape Wren",
            body: "Wren goes Friday. Buyer is from Linden Inlet, not Kerstadt — your hint helped. Thank you. See you on the dry side. — O.",
            choices: [
                LetterChoice(id: "C1", text: "Tell him you'll miss seeing the running lights.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_FAM_018", nightAvailable: 118, correspondent: .daughter,
            title: "I learned morse",
            body: "Papa I can do all the letters now. -.-. .- .-.. .-.. .- (Calla). When are you home for good.",
            choices: [
                LetterChoice(id: "C1", text: "Tell her: soon. Promise.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: 6),
                    LetterEffect(kind: .arc, arc: .family, delta: 5),
                    LetterEffect(kind: .flag, flag: "promised_home_for_good")
                ]),
                LetterChoice(id: "C2", text: "Tell her: the cape still needs me a while longer.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .daughter, delta: -3),
                    LetterEffect(kind: .arc, arc: .family, delta: -3),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 2)
                ])
            ]
        )
    ]

    // INSPECTOR ARC — 12 letters (inspector + society)
    static let inspectorLetters: [Letter] = [
        Letter(
            id: "L_INS_001", nightAvailable: 4, correspondent: .society,
            title: "Annual circular",
            body: "The Society reminds keepers that Inspector Ravna Hess of Vossengard will tour the northern capes this year. Logs to be in order. Fuel tank manifests current. Cordially, the Society of Lamp & Lens.",
            choices: [
                LetterChoice(id: "C1", text: "Acknowledge formally.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 2),
                    LetterEffect(kind: .reputation, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "File and forget.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: -1)
                ])
            ]
        ),
        Letter(
            id: "L_INS_002", nightAvailable: 11, correspondent: .navalInspector,
            title: "Site visit forthcoming",
            body: "Keeper — I will visit your cape between nights 18 and 30. Have logs to hand. Have the fuel tank dipped. Have a kettle on. — R. Hess",
            choices: [
                LetterChoice(id: "C1", text: "Reply: all in order, welcome.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 4),
                    LetterEffect(kind: .reputation, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Reply: tank dipped at low tide only.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 1)
                ]),
                LetterChoice(id: "C3", text: "Don't reply.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: -3),
                    LetterEffect(kind: .reputation, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_INS_003", nightAvailable: 19, correspondent: .navalInspector,
            title: "Postponement",
            body: "Cape inspection postponed to nights 38–46 due to fleet exercises. Maintain your log discipline. — R. Hess",
            choices: [
                LetterChoice(id: "C1", text: "Use the extra time to overhaul the lamp.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 3),
                    LetterEffect(kind: .flag, flag: "overhaul_planned")
                ]),
                LetterChoice(id: "C2", text: "Note it and move on.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 1)
                ])
            ]
        ),
        Letter(
            id: "L_INS_004", nightAvailable: 32, correspondent: .society,
            title: "Stipend",
            body: "Quarterly stipend enclosed: 60 marks. Submit Quarter Two log abstract by night 60.",
            choices: [
                LetterChoice(id: "C1", text: "Accept gracefully.", effects: [
                    LetterEffect(kind: .money, delta: 60),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 2)
                ])
            ]
        ),
        Letter(
            id: "L_INS_005", nightAvailable: 42, correspondent: .navalInspector,
            title: "Arrived",
            body: "Keeper — I am at the cape. The bell on the lower platform is salt-eaten and the lens is unevenly cleaned in the south octant. Expect questions tomorrow. — R. Hess",
            choices: [
                LetterChoice(id: "C1", text: "Apologize. Promise full overhaul tonight.", effects: [
                    LetterEffect(kind: .fatigue, delta: 8),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 5),
                    LetterEffect(kind: .reputation, delta: 4)
                ]),
                LetterChoice(id: "C2", text: "Explain: south octant is salt-prone, weekly maintenance only.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 2),
                    LetterEffect(kind: .reputation, delta: 1)
                ]),
                LetterChoice(id: "C3", text: "Be cold. The lamp lights ships, not inspectors.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: -5),
                    LetterEffect(kind: .reputation, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_INS_006", nightAvailable: 47, correspondent: .navalInspector,
            title: "Departing",
            body: "I leave you a stamped certificate, contingent. Re-cleaning of octant by next pass. The lamp keeps fine timing. Few cape stations do. — R. Hess",
            choices: [
                LetterChoice(id: "C1", text: "Thank her formally.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 3),
                    LetterEffect(kind: .reputation, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Decline to acknowledge.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_INS_007", nightAvailable: 56, correspondent: .society,
            title: "Quarter Two abstract overdue",
            body: "Submit your Q2 log abstract immediately. Stipend at risk.",
            choices: [
                LetterChoice(id: "C1", text: "Send it tonight. Stay up.", effects: [
                    LetterEffect(kind: .fatigue, delta: 5),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Skip it.", effects: [
                    LetterEffect(kind: .money, delta: -30),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -4),
                    LetterEffect(kind: .reputation, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_INS_008", nightAvailable: 70, correspondent: .navalInspector,
            title: "Auxiliary signal mirror",
            body: "Issuing you an auxiliary signal mirror, by carrier on the 75th. Use it. — R. Hess",
            choices: [
                LetterChoice(id: "C1", text: "Thank her; promise to install it.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 3),
                    LetterEffect(kind: .flag, flag: "second_mirror")
                ])
            ]
        ),
        Letter(
            id: "L_INS_009", nightAvailable: 82, correspondent: .society,
            title: "Promotion",
            body: "The Society has noted your record and considers you for Senior Keeper status on completion of the cape watch.",
            choices: [
                LetterChoice(id: "C1", text: "Reply: honored to be considered.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 5),
                    LetterEffect(kind: .reputation, delta: 5)
                ]),
                LetterChoice(id: "C2", text: "Decline. Not interested.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: -5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_INS_010", nightAvailable: 93, correspondent: .navalInspector,
            title: "Winter pass",
            body: "Considering another visit during the worst of the winter. I want to see how you handle the blizzards. Yes or no. — R. Hess",
            choices: [
                LetterChoice(id: "C1", text: "Yes. Come watch.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 5),
                    LetterEffect(kind: .fatigue, delta: 5)
                ]),
                LetterChoice(id: "C2", text: "No. The cape is yours to imagine.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: -3),
                    LetterEffect(kind: .arc, arc: .family, delta: 1)
                ])
            ]
        ),
        Letter(
            id: "L_INS_011", nightAvailable: 105, correspondent: .navalInspector,
            title: "Arrived in storm",
            body: "Keeper, I am in your kitchen. The blizzard is a proper one. Coffee, please. — R. Hess",
            choices: [
                LetterChoice(id: "C1", text: "Welcome her. Brew the strong stuff.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 6),
                    LetterEffect(kind: .reputation, delta: 4),
                    LetterEffect(kind: .flag, flag: "blizzard_visit")
                ])
            ]
        ),
        Letter(
            id: "L_INS_012", nightAvailable: 117, correspondent: .society,
            title: "Senior Keeper Offer",
            body: "Pending positive close of watch, you are offered Senior Keeper, North-Cape Region. Annual stipend increased. Decide before night 120.",
            choices: [
                LetterChoice(id: "C1", text: "Accept. Sign the ledger.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 8),
                    LetterEffect(kind: .reputation, delta: 6),
                    LetterEffect(kind: .flag, flag: "accepted_senior_keeper")
                ]),
                LetterChoice(id: "C2", text: "Decline. The lamp is enough.", effects: [
                    LetterEffect(kind: .arc, arc: .family, delta: 4),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -8)
                ])
            ]
        )
    ]

    // WRECK ARC — 10 letters (oldFriend)
    static let wreckLetters: [Letter] = [
        Letter(
            id: "L_WRK_001", nightAvailable: 7, correspondent: .oldFriend,
            title: "Old friend",
            body: "It’s Tobias, from the old harbor school days. I tracked you down to the cape lighthouse. There is something at the foot of your cliff. We were near it as boys. Remember? — T.",
            choices: [
                LetterChoice(id: "C1", text: "Yes — the rusted hull I saw at low tide.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .oldFriend, delta: 4),
                    LetterEffect(kind: .arc, arc: .wreck, delta: 3),
                    LetterEffect(kind: .flag, flag: "remembers_hull")
                ]),
                LetterChoice(id: "C2", text: "I remember nothing.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .oldFriend, delta: -1),
                    LetterEffect(kind: .arc, arc: .wreck, delta: 1)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_002", nightAvailable: 17, correspondent: .oldFriend,
            title: "It was Reed's hull",
            body: "I think the wreck was the SUNDERED HULL, Captain Tobias Reed — yes, my namesake. He was a distant uncle. He went down in 1881, three crew survived. The cargo was never recovered.",
            choices: [
                LetterChoice(id: "C1", text: "What was the cargo?", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Leave the dead alone.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .oldFriend, delta: -3),
                    LetterEffect(kind: .arc, arc: .wreck, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_003", nightAvailable: 26, correspondent: .oldFriend,
            title: "Manifest",
            body: "The cargo — I have an old harbor manifest. Iron, sealing wax, three locked boxes of unrecorded contents bound for Vossengard naval arsenal. The boxes were never logged ashore.",
            choices: [
                LetterChoice(id: "C1", text: "Three locked boxes... investigate the cave when you can.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 4),
                    LetterEffect(kind: .flag, flag: "investigate_boxes")
                ]),
                LetterChoice(id: "C2", text: "Tell him to drop it.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .oldFriend, delta: -2),
                    LetterEffect(kind: .arc, arc: .wreck, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_004", nightAvailable: 38, correspondent: .oldFriend,
            title: "Cave stair",
            body: "There’s a cliff stair down to the tide pools, behind the gardener’s shed. I remember it. Mind your footing. — T.",
            choices: [
                LetterChoice(id: "C1", text: "Thank him. Plan to descend.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 3),
                    LetterEffect(kind: .flag, flag: "stair_known")
                ])
            ]
        ),
        Letter(
            id: "L_WRK_005", nightAvailable: 50, correspondent: .oldFriend,
            title: "Inspector and the wreck",
            body: "If Inspector Hess shows interest in the cliff stair, do not lead her down. The Vossengard navy will reclaim anything they consider lost property.",
            choices: [
                LetterChoice(id: "C1", text: "Agree. Keep the stair to ourselves.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 4),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -3)
                ]),
                LetterChoice(id: "C2", text: "Refuse. The inspector deserves the truth.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: -3),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 5)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_006", nightAvailable: 65, correspondent: .oldFriend,
            title: "Lockbox",
            body: "You found a locked iron box, didn’t you? I dreamt it. There were three. The Reed family lockmaker used a left-handed key bit; you can pry it with a copper fitting and patience.",
            choices: [
                LetterChoice(id: "C1", text: "Try the copper fitting trick.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 5),
                    LetterEffect(kind: .flag, flag: "lockbox_method")
                ]),
                LetterChoice(id: "C2", text: "Don't try. Leave it sealed.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_007", nightAvailable: 78, correspondent: .oldFriend,
            title: "The third box",
            body: "Two boxes held what we expected: sealed naval orders. The third — if you find a third — was rumored to contain a survey instrument unlike any other. Aurora-related. The Vossengard navy denies it ever existed.",
            choices: [
                LetterChoice(id: "C1", text: "Continue searching.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 4),
                    LetterEffect(kind: .arc, arc: .aurora, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Stop here.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_008", nightAvailable: 89, correspondent: .oldFriend,
            title: "Tobias's last letter",
            body: "I am sick. Letters slow. If you find anything that looks like polished green mineral, do not show it to anyone. Especially not the unsigned writer who has been writing to you. — Tobias",
            choices: [
                LetterChoice(id: "C1", text: "Promise to keep it secret.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 5),
                    LetterEffect(kind: .arc, arc: .aurora, delta: -2)
                ]),
                LetterChoice(id: "C2", text: "Tell him you'll show whoever asks.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: -3),
                    LetterEffect(kind: .arc, arc: .aurora, delta: 4)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_009", nightAvailable: 102, correspondent: .oldFriend,
            title: "Estate",
            body: "Tobias has died. His estate-agent has forwarded the rest of his Reed-family papers. They are with you on the next packet.",
            choices: [
                LetterChoice(id: "C1", text: "Accept. Read them.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 5),
                    LetterEffect(kind: .reputation, delta: 1)
                ])
            ]
        ),
        Letter(
            id: "L_WRK_010", nightAvailable: 115, correspondent: .oldFriend,
            title: "What to do with the wreck",
            body: "(Posthumously forwarded by estate.) If you’re reading this you’ve outlived me. The wreck contents are yours to decide. Hand them to the navy, or sink them deeper, or sell them at the harbor. — T.",
            choices: [
                LetterChoice(id: "C1", text: "Hand them to the navy.", effects: [
                    LetterEffect(kind: .arc, arc: .inspector, delta: 6),
                    LetterEffect(kind: .arc, arc: .wreck, delta: 4),
                    LetterEffect(kind: .reputation, delta: 4),
                    LetterEffect(kind: .flag, flag: "wreck_to_navy")
                ]),
                LetterChoice(id: "C2", text: "Sink them deeper.", effects: [
                    LetterEffect(kind: .arc, arc: .wreck, delta: 6),
                    LetterEffect(kind: .arc, arc: .aurora, delta: 2),
                    LetterEffect(kind: .flag, flag: "wreck_to_sea")
                ]),
                LetterChoice(id: "C3", text: "Sell them quietly at the harbor.", effects: [
                    LetterEffect(kind: .money, delta: 80),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 5),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -3),
                    LetterEffect(kind: .reputation, delta: -3),
                    LetterEffect(kind: .flag, flag: "wreck_sold")
                ])
            ]
        )
    ]

    // SMUGGLER ARC — 10 letters
    static let smugglerLetters: [Letter] = [
        Letter(
            id: "L_SMU_001", nightAvailable: 13, correspondent: .harborMaster,
            title: "Beam scheduling",
            body: "Keeper — I’m drafting a list of nights when your beam is rotated against an alternate compass. I will share it confidentially. Note the dates. — P. Vaal",
            choices: [
                LetterChoice(id: "C1", text: "Cooperate. Schedule shared.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 3),
                    LetterEffect(kind: .reputation, delta: 1)
                ]),
                LetterChoice(id: "C2", text: "Decline. My beam is for ships, not signals.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -3),
                    LetterEffect(kind: .reputation, delta: -1)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_002", nightAvailable: 22, correspondent: .harborMaster,
            title: "Iron Pelican",
            body: "The Iron Pelican will pass tonight, third hour. Captain Velm. If your log shows it as identified, the Society won’t question why my customs inspectors swarm her at the next port.",
            choices: [
                LetterChoice(id: "C1", text: "Identify when she passes — give Vaal the ID.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 5),
                    LetterEffect(kind: .reputation, delta: 2),
                    LetterEffect(kind: .flag, flag: "ratted_pelican")
                ]),
                LetterChoice(id: "C2", text: "Refuse — you don’t collude with customs.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -4)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_003", nightAvailable: 33, correspondent: .harborMaster,
            title: "Olen",
            body: "Keeper — your brother’s name has come up in a manifest discrepancy. I have not acted on it. Yet. — P. Vaal",
            choices: [
                LetterChoice(id: "C1", text: "Plead his case. He's a fisherman, not a smuggler.", effects: [
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: 3),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -3),
                    LetterEffect(kind: .flag, flag: "shielded_olen")
                ]),
                LetterChoice(id: "C2", text: "Ask Vaal to investigate properly.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 4),
                    LetterEffect(kind: .arc, arc: .family, delta: -5),
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: -5)
                ]),
                LetterChoice(id: "C3", text: "Bribe Vaal to keep Olen out.", effects: [
                    LetterEffect(kind: .money, delta: -50),
                    LetterEffect(kind: .relationship, correspondent: .brother, delta: 3),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -2),
                    LetterEffect(kind: .reputation, delta: -3),
                    LetterEffect(kind: .flag, flag: "bribed_vaal")
                ])
            ]
        ),
        Letter(
            id: "L_SMU_004", nightAvailable: 46, correspondent: .harborMaster,
            title: "Pattern",
            body: "Several manifests show late-month tonnage discrepancies between Kerstadt and Olstrand. The pattern aligns with your beam-down hours.",
            choices: [
                LetterChoice(id: "C1", text: "Adjust beam discipline. Tighten the schedule.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 4),
                    LetterEffect(kind: .reputation, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "Keep current schedule. Coincidence.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_005", nightAvailable: 59, correspondent: .harborMaster,
            title: "Maremont Tanker",
            body: "Maremont Tanker tonight, fifth hour. Identify her or don’t — but tell me if her flag is wrong.",
            choices: [
                LetterChoice(id: "C1", text: "Watch carefully. Report the flag.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 5),
                    LetterEffect(kind: .reputation, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "Pass. Not my fight.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_006", nightAvailable: 71, correspondent: .harborMaster,
            title: "Reward",
            body: "Quiet reward for your past help. Forty marks. Don’t spend it at the only bakery on the cape.",
            choices: [
                LetterChoice(id: "C1", text: "Accept gratefully.", effects: [
                    LetterEffect(kind: .money, delta: 40),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Refuse. Send it back.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 5),
                    LetterEffect(kind: .reputation, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_007", nightAvailable: 85, correspondent: .harborMaster,
            title: "Threat",
            body: "Word has reached the cargo cartel that you've been helping me. A man with a Kerstadt accent has been asking about your wife’s address. Be careful. — P. Vaal",
            choices: [
                LetterChoice(id: "C1", text: "Wire Mira immediately. Move her to her sister’s.", effects: [
                    LetterEffect(kind: .money, delta: -25),
                    LetterEffect(kind: .relationship, correspondent: .wife, delta: 4),
                    LetterEffect(kind: .arc, arc: .family, delta: 4),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 2)
                ]),
                LetterChoice(id: "C2", text: "Tell Vaal: identify the Kerstadt man. Now.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 5),
                    LetterEffect(kind: .arc, arc: .family, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_008", nightAvailable: 98, correspondent: .harborMaster,
            title: "Storm cover",
            body: "Tonight is a gale; the cartel will try a run while my customs cutters stay in harbor. Hold your beam steady. Identify everything. — Vaal",
            choices: [
                LetterChoice(id: "C1", text: "Hold the beam. Identify everything.", effects: [
                    LetterEffect(kind: .fatigue, delta: 10),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 6),
                    LetterEffect(kind: .reputation, delta: 4)
                ]),
                LetterChoice(id: "C2", text: "Beam down the way they want; you’re tired.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -6),
                    LetterEffect(kind: .reputation, delta: -4)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_009", nightAvailable: 110, correspondent: .harborMaster,
            title: "Arrests",
            body: "Six arrests today. The Iron Pelican is in our docks. Captain Velm in irons. Your name is in my report.",
            choices: [
                LetterChoice(id: "C1", text: "Acknowledge with quiet pride.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 6),
                    LetterEffect(kind: .reputation, delta: 5)
                ]),
                LetterChoice(id: "C2", text: "Ask Vaal to keep your name off the public record.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 3),
                    LetterEffect(kind: .arc, arc: .family, delta: 3),
                    LetterEffect(kind: .reputation, delta: 2)
                ])
            ]
        ),
        Letter(
            id: "L_SMU_010", nightAvailable: 119, correspondent: .harborMaster,
            title: "Closing",
            body: "You did good work, keeper. The cartel will probably re-form somewhere south by next year. For your watch — thank you. — P. Vaal",
            choices: [
                LetterChoice(id: "C1", text: "Reply with thanks. Close the file.", effects: [
                    LetterEffect(kind: .arc, arc: .smugglers, delta: 5),
                    LetterEffect(kind: .reputation, delta: 3)
                ])
            ]
        )
    ]

    // AURORA ARC — 10 letters (stranger)
    static let auroraLetters: [Letter] = [
        Letter(
            id: "L_AUR_001", nightAvailable: 16, correspondent: .stranger,
            title: "Unsigned",
            body: "You have seen the green ribbons across the cape on clear nights. You will see them more. — (no signature)",
            choices: [
                LetterChoice(id: "C1", text: "File it carefully.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Burn it.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -2)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_002", nightAvailable: 27, correspondent: .stranger,
            title: "Below the lamp",
            body: "Below the lamp there is a green shard older than the harbor city. When the aurora touches the cape they sing to each other. Listen with the lamp dark.",
            choices: [
                LetterChoice(id: "C1", text: "Plan to extinguish the lamp briefly during aurora.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 5),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -3),
                    LetterEffect(kind: .flag, flag: "willing_to_dim")
                ]),
                LetterChoice(id: "C2", text: "Reject. The lamp does not go out.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -3),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_003", nightAvailable: 41, correspondent: .stranger,
            title: "Find the shard",
            body: "Patrol the cave at low tide. The shard is small as a thumbnail and warm in the hand.",
            choices: [
                LetterChoice(id: "C1", text: "Search at next opportunity.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 4)
                ]),
                LetterChoice(id: "C2", text: "Ignore.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_004", nightAvailable: 54, correspondent: .stranger,
            title: "Wreck and the shard",
            body: "The wreck carried the third box. The third box carried a survey-stone — the same mineral. The Vossengard navy knew. Tobias knew. Now you do.",
            choices: [
                LetterChoice(id: "C1", text: "Continue the line of inquiry.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 5),
                    LetterEffect(kind: .arc, arc: .wreck, delta: 3)
                ]),
                LetterChoice(id: "C2", text: "Refuse to play the stranger's game.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -4)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_005", nightAvailable: 68, correspondent: .stranger,
            title: "Dim the lamp",
            body: "On the next aurora night, dim the lamp for one hour. See what passes.",
            choices: [
                LetterChoice(id: "C1", text: "Do it.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 7),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -5),
                    LetterEffect(kind: .reputation, delta: -3),
                    LetterEffect(kind: .flag, flag: "dimmed_lamp")
                ]),
                LetterChoice(id: "C2", text: "Don’t.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -3),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 3)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_006", nightAvailable: 79, correspondent: .stranger,
            title: "What you saw",
            body: "If you dimmed the lamp, you saw a shape against the aurora that was not a ship. Write to me what color it was. (If you did not dim, never mind.)",
            choices: [
                LetterChoice(id: "C1", text: "Green-violet.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 4)
                ]),
                LetterChoice(id: "C2", text: "Saw nothing.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -1)
                ]),
                LetterChoice(id: "C3", text: "I did not dim.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_007", nightAvailable: 90, correspondent: .stranger,
            title: "The Aurora Margin",
            body: "The yacht is mine. The Aurora Margin. We will pass your cape on the 95th. Do not identify us in your log.",
            choices: [
                LetterChoice(id: "C1", text: "Agree. Do not identify the yacht.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 6),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -4),
                    LetterEffect(kind: .arc, arc: .smugglers, delta: -3),
                    LetterEffect(kind: .flag, flag: "hid_yacht")
                ]),
                LetterChoice(id: "C2", text: "Refuse. The yacht goes in the log like any ship.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -5),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 5)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_008", nightAvailable: 103, correspondent: .stranger,
            title: "The shard, returned",
            body: "Send the shard to me. By the next packet. Hide it in cotton. Mark the parcel 'naturalist samples.'",
            choices: [
                LetterChoice(id: "C1", text: "Send it. Mark the parcel.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 7),
                    LetterEffect(kind: .arc, arc: .inspector, delta: -3),
                    LetterEffect(kind: .flag, flag: "sent_shard")
                ]),
                LetterChoice(id: "C2", text: "Keep the shard.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -3)
                ]),
                LetterChoice(id: "C3", text: "Hand the shard to Inspector Hess.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -6),
                    LetterEffect(kind: .arc, arc: .inspector, delta: 6),
                    LetterEffect(kind: .reputation, delta: 4),
                    LetterEffect(kind: .flag, flag: "shard_to_navy")
                ])
            ]
        ),
        Letter(
            id: "L_AUR_009", nightAvailable: 112, correspondent: .stranger,
            title: "Why the cape",
            body: "The cape is one of seven points on the planet where the aurora touches the bedrock. The lamp is older than you. It is older than the Society. It is older than Vossengard. Carry it kindly.",
            choices: [
                LetterChoice(id: "C1", text: "I will.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 5)
                ]),
                LetterChoice(id: "C2", text: "It is a lamp.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: -3)
                ])
            ]
        ),
        Letter(
            id: "L_AUR_010", nightAvailable: 119, correspondent: .stranger,
            title: "Last letter",
            body: "On the 120th night, watch the aurora. Whatever you choose at the lamp, the cape will choose with you.",
            choices: [
                LetterChoice(id: "C1", text: "I will watch.", effects: [
                    LetterEffect(kind: .arc, arc: .aurora, delta: 6)
                ])
            ]
        )
    ]
}
