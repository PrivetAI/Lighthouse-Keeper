import SwiftUI

// MARK: - Ship Identify Sheet

struct ShipIdentifySheet: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    let shipId: String
    let onResult: (Bool) -> Void

    @State private var pickedFlag: String?
    @State private var pickedKind: ShipSilhouetteKind?
    @State private var hint: String? = nil

    var body: some View {
        VStack(spacing: 12) {
            if let ship = LighthouseKeeperCatalog.ships.first(where: { $0.id == shipId }) {
                ZStack(alignment: .topLeading) {
                    LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .top, endPoint: .bottom)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Vessel in beam")
                            .font(.system(size: 11, weight: .bold))
                            .tracking(2)
                            .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                        HStack(alignment: .center, spacing: 16) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("HULL")
                                    .font(.system(size: 9, weight: .bold))
                                    .tracking(1.5)
                                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.55))
                                ShipSilhouette(kind: ship.kind, color: LighthouseKeeperPalette.amber, size: CGSize(width: 100, height: 38))
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("FLAG")
                                    .font(.system(size: 9, weight: .bold))
                                    .tracking(1.5)
                                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.55))
                                FlagGlyph(nation: ship.flag, size: CGSize(width: 56, height: 32))
                            }
                            Spacer()
                        }
                    }
                    .padding(14)
                }
                .frame(height: 110)

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Compare the silhouette and flag above against the registry. Match both to attempt an identification (weather affects success).")
                            .font(.system(size: 13))
                            .foregroundColor(LighthouseKeeperPalette.inkMid)

                        Text("Silhouette")
                            .font(.system(size: 12, weight: .bold))
                            .tracking(1.5)
                            .foregroundColor(LighthouseKeeperPalette.inkMid)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                            ForEach(ShipSilhouetteKind.allCases, id: \.self) { kind in
                                Button {
                                    pickedKind = kind
                                } label: {
                                    VStack(spacing: 4) {
                                        ShipSilhouette(kind: kind, color: pickedKind == kind ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.slate, size: CGSize(width: 64, height: 30))
                                        Text(kind.rawValue.capitalized)
                                            .font(.system(size: 10, weight: .semibold))
                                            .foregroundColor(LighthouseKeeperPalette.inkDark)
                                    }
                                    .padding(6)
                                    .background(pickedKind == kind ? LighthouseKeeperPalette.surfaceSunken : LighthouseKeeperPalette.surface)
                                    .cornerRadius(6)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(pickedKind == kind ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.divider, lineWidth: 1))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }

                        Text("Flag")
                            .font(.system(size: 12, weight: .bold))
                            .tracking(1.5)
                            .foregroundColor(LighthouseKeeperPalette.inkMid)
                            .padding(.top, 6)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 4), spacing: 8) {
                            ForEach(LighthouseKeeperCatalog.nations, id: \.self) { nation in
                                Button {
                                    pickedFlag = nation
                                } label: {
                                    VStack(spacing: 4) {
                                        FlagGlyph(nation: nation, size: CGSize(width: 56, height: 32))
                                        Text(nation)
                                            .font(.system(size: 10, weight: .semibold))
                                            .foregroundColor(LighthouseKeeperPalette.inkDark)
                                    }
                                    .padding(6)
                                    .background(pickedFlag == nation ? LighthouseKeeperPalette.surfaceSunken : LighthouseKeeperPalette.surface)
                                    .cornerRadius(6)
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(pickedFlag == nation ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.divider, lineWidth: 1))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }

                        if let h = hint {
                            Text(h)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(LighthouseKeeperPalette.rust)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }

                HStack(spacing: 10) {
                    Button {
                        onResult(false)
                    } label: {
                        Text("Let pass anonymously")
                            .font(.system(size: 13, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(LighthouseKeeperPalette.slate)
                            .foregroundColor(LighthouseKeeperPalette.sand)
                            .cornerRadius(6)
                    }
                    Button {
                        guard let pk = pickedKind, let pf = pickedFlag else {
                            hint = "Pick a silhouette and a flag first."
                            return
                        }
                        let correct = (pk == ship.kind && pf == ship.flag)
                        onResult(correct)
                    } label: {
                        Text("Identify")
                            .font(.system(size: 13, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(LighthouseKeeperPalette.amber)
                            .foregroundColor(LighthouseKeeperPalette.teal)
                            .cornerRadius(6)
                    }
                }
                .padding(14)
            }
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}

// MARK: - Weather Guess Sheet

struct WeatherGuessSheet: View {
    let onPicked: (WeatherKind) -> Void

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("LOG WEATHER")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(2)
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                Text("What sky is over the cape?")
                    .font(.system(size: 18, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .leading, endPoint: .trailing))

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(WeatherKind.allCases, id: \.self) { kind in
                        Button {
                            onPicked(kind)
                        } label: {
                            VStack(spacing: 4) {
                                WeatherGlyph(kind: kind, size: 36, color: LighthouseKeeperPalette.amber)
                                Text(kind.label)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(LighthouseKeeperPalette.surfaceSunken)
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(14)
            }
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}

// MARK: - Subsystem Repair Picker

struct SubsystemRepairPicker: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    let onClose: (String?) -> Void

    @State private var feedback: String? = nil

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("REPAIR SUBSYSTEM")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(2)
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                Text("Pick a subsystem to mend")
                    .font(.system(size: 18, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .leading, endPoint: .trailing))

            if let f = feedback {
                Text(f)
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
                    .padding(.horizontal, 14)
            }

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(SubsystemKind.allCases, id: \.self) { kind in
                        Button {
                            let res = store.applyRepair(kind)
                            switch res {
                            case .success(let g, let c):
                                feedback = "Repaired \(kind.label): +\(g) condition, -\(c) m."
                            case .missingPart(let part):
                                feedback = "Missing part: \(part.label). Visit inventory."
                            case .notEnoughMoney(let need):
                                feedback = "Not enough money. Need \(need) m."
                            case .noActions:
                                feedback = "No actions remain today."
                            }
                        } label: {
                            HStack(spacing: 10) {
                                conditionBar(value: store.state.subsystemCondition[kind.rawValue] ?? 0)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(kind.label)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(LighthouseKeeperPalette.inkDark)
                                    Text(kind.description)
                                        .font(.system(size: 11))
                                        .foregroundColor(LighthouseKeeperPalette.inkMid)
                                        .lineLimit(2)
                                    HStack(spacing: 4) {
                                        ForEach(kind.requiredParts, id: \.self) { p in
                                            Text(p.label)
                                                .font(.system(size: 9, weight: .semibold))
                                                .padding(.horizontal, 5)
                                                .padding(.vertical, 2)
                                                .background(LighthouseKeeperPalette.surfaceSunken)
                                                .foregroundColor(LighthouseKeeperPalette.inkMid)
                                                .cornerRadius(3)
                                        }
                                    }
                                }
                                Spacer()
                                Text("\(store.state.subsystemCondition[kind.rawValue] ?? 0)")
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundColor(LighthouseKeeperPalette.teal)
                            }
                            .padding(10)
                            .background(LighthouseKeeperPalette.surface)
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 14)
            }
            HStack {
                Spacer()
                Button {
                    onClose(feedback)
                } label: {
                    Text("Close")
                        .font(.system(size: 13, weight: .bold))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(LighthouseKeeperPalette.teal)
                        .foregroundColor(LighthouseKeeperPalette.sand)
                        .cornerRadius(6)
                }
                Spacer()
            }
            .padding(.bottom, 12)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .preferredColorScheme(.light)
    }

    private func conditionBar(value: Int) -> some View {
        ZStack(alignment: .leading) {
            Capsule().fill(LighthouseKeeperPalette.divider).frame(width: 10, height: 56)
            Capsule()
                .fill(value < 30 ? LighthouseKeeperPalette.rust : (value < 70 ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.teal))
                .frame(width: 10, height: max(6, CGFloat(value) * 0.56))
                .offset(y: CGFloat(56 - max(6, CGFloat(value) * 0.56)))
        }
        .frame(width: 10, height: 56)
    }
}

// MARK: - Inventory Sheet

struct InventorySheet: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @Environment(\.presentationMode) var presentation
    @State private var lastMessage: String? = nil

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("INVENTORY")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(2)
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                Text("Buy and sell parts at harbor prices")
                    .font(.system(size: 16, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)
                Text("Money: \(store.state.money) m   Weather mult: \(String(format: "%.2f", store.currentWeather.repairCostMultiplier))×")
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.85))
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .leading, endPoint: .trailing))

            if let m = lastMessage {
                Text(m)
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
                    .padding(.horizontal, 14)
            }

            ScrollView {
                VStack(spacing: 8) {
                    ForEach(InventoryPart.allCases, id: \.self) { p in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(p.label)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                                Text("Base: \(p.basePrice) m")
                                    .font(.system(size: 11))
                                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                            }
                            Spacer()
                            Text("×\(store.state.partsInventory[p.rawValue] ?? 0)")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(LighthouseKeeperPalette.teal)
                                .padding(.horizontal, 10)
                            Button {
                                if store.buyPart(p) {
                                    lastMessage = "Bought 1 × \(p.label)."
                                } else {
                                    lastMessage = "Not enough money for \(p.label)."
                                }
                            } label: {
                                Text("Buy")
                                    .font(.system(size: 12, weight: .bold))
                                    .padding(.horizontal, 10).padding(.vertical, 6)
                                    .background(LighthouseKeeperPalette.amber)
                                    .foregroundColor(LighthouseKeeperPalette.teal)
                                    .cornerRadius(4)
                            }
                            Button {
                                if store.sellPart(p) {
                                    lastMessage = "Sold 1 × \(p.label)."
                                } else {
                                    lastMessage = "You have none to sell."
                                }
                            } label: {
                                Text("Sell")
                                    .font(.system(size: 12, weight: .bold))
                                    .padding(.horizontal, 10).padding(.vertical, 6)
                                    .background(LighthouseKeeperPalette.slate)
                                    .foregroundColor(LighthouseKeeperPalette.sand)
                                    .cornerRadius(4)
                            }
                        }
                        .padding(10)
                        .background(LighthouseKeeperPalette.surface)
                        .cornerRadius(6)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
                    }
                }
                .padding(.horizontal, 14)
            }
            Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Close")
                    .font(.system(size: 13, weight: .bold))
                    .padding(.horizontal, 18).padding(.vertical, 10)
                    .background(LighthouseKeeperPalette.teal)
                    .foregroundColor(LighthouseKeeperPalette.sand)
                    .cornerRadius(6)
            }
            .padding(.bottom, 12)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}

// MARK: - Cave Patrol Result Sheet

struct CavePatrolResultSheet: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @Environment(\.presentationMode) var presentation
    @State private var lastArtifact: CaveArtifact? = nil

    var body: some View {
        VStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text("CLIFF CAVE")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(2)
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.7))
                Text("Low-tide patrol")
                    .font(.system(size: 18, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .leading, endPoint: .trailing))

            VStack(spacing: 10) {
                Text("You picked your way down the cliff stair at low tide.")
                    .font(.system(size: 13))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Artifacts found: \(store.state.caveArtifacts.count) / \(CaveArtifact.allCases.count)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                if let lastRaw = store.state.lastCaveArtifactId,
                   store.state.caveArtifacts.contains(lastRaw),
                   let art = CaveArtifact(rawValue: lastRaw) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Latest find")
                            .font(.system(size: 11, weight: .bold))
                            .tracking(1.5)
                            .foregroundColor(LighthouseKeeperPalette.inkMid)
                        Text(art.label)
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(LighthouseKeeperPalette.teal)
                        Text(art.lore)
                            .font(.system(size: 12))
                            .foregroundColor(LighthouseKeeperPalette.inkMid)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(6)
                } else {
                    Text("Nothing of note this trip. The tide already took it back.")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(LighthouseKeeperPalette.inkMid)
                }
            }
            .padding(.horizontal, 14)

            Spacer()
            Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Climb back up")
                    .font(.system(size: 13, weight: .bold))
                    .padding(.horizontal, 18).padding(.vertical, 10)
                    .background(LighthouseKeeperPalette.teal)
                    .foregroundColor(LighthouseKeeperPalette.sand)
                    .cornerRadius(6)
            }
            .padding(.bottom, 16)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}
