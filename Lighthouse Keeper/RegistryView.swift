import SwiftUI

struct RegistryView: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @State private var filterFlag: String? = nil
    @State private var filterKind: ShipSilhouetteKind? = nil
    @State private var showOnlyIdentified = false

    var body: some View {
        VStack(spacing: 0) {
            filterBar
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(filtered, id: \.id) { ship in
                        NavigationLink(destination: ShipDetail(ship: ship)) {
                            shipRow(ship)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(12)
            }
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle("Ship Registry", displayMode: .inline)
    }

    private var filterBar: some View {
        VStack(spacing: 6) {
            HStack {
                Text("\(filtered.count) ships")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(1.5)
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                Spacer()
                Button {
                    showOnlyIdentified.toggle()
                } label: {
                    HStack(spacing: 4) {
                        if showOnlyIdentified {
                            CheckGlyph(size: 14, color: LighthouseKeeperPalette.teal)
                        }
                        Text(showOnlyIdentified ? "Only identified" : "All")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(LighthouseKeeperPalette.inkDark)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 6)
                    .background(LighthouseKeeperPalette.surfaceSunken)
                    .cornerRadius(4)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    Button {
                        filterFlag = nil
                    } label: {
                        Text("All Flags")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(filterFlag == nil ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.surfaceSunken)
                            .foregroundColor(filterFlag == nil ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkDark)
                            .cornerRadius(4)
                    }
                    ForEach(LighthouseKeeperCatalog.nations, id: \.self) { nation in
                        Button {
                            filterFlag = (filterFlag == nation) ? nil : nation
                        } label: {
                            HStack(spacing: 4) {
                                FlagGlyph(nation: nation, size: CGSize(width: 16, height: 10))
                                Text(nation)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(filterFlag == nation ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkDark)
                            }
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(filterFlag == nation ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.surfaceSunken)
                            .cornerRadius(4)
                        }
                    }
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    Button {
                        filterKind = nil
                    } label: {
                        Text("All Kinds")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(filterKind == nil ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.surfaceSunken)
                            .foregroundColor(filterKind == nil ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkDark)
                            .cornerRadius(4)
                    }
                    ForEach(ShipSilhouetteKind.allCases, id: \.self) { k in
                        Button {
                            filterKind = (filterKind == k) ? nil : k
                        } label: {
                            HStack(spacing: 4) {
                                ShipSilhouette(kind: k, color: LighthouseKeeperPalette.slate, size: CGSize(width: 22, height: 12))
                                Text(k.rawValue.capitalized)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(filterKind == k ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkDark)
                            }
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(filterKind == k ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.surfaceSunken)
                            .cornerRadius(4)
                        }
                    }
                }
            }
        }
        .padding(12)
        .background(LighthouseKeeperPalette.surfaceSunken)
    }

    private var filtered: [ShipRegistryEntry] {
        LighthouseKeeperCatalog.ships.filter { ship in
            if let f = filterFlag, ship.flag != f { return false }
            if let k = filterKind, ship.kind != k { return false }
            if showOnlyIdentified, !store.state.identifiedShips.contains(ship.id) { return false }
            return true
        }
    }

    private func shipRow(_ ship: ShipRegistryEntry) -> some View {
        let identified = store.state.identifiedShips.contains(ship.id)
        return HStack(spacing: 10) {
            ShipSilhouette(kind: ship.kind, color: identified ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.slate, size: CGSize(width: 80, height: 40))
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(ship.name)
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(LighthouseKeeperPalette.inkDark)
                    if ship.storyShip {
                        Text("Story")
                            .font(.system(size: 9, weight: .bold))
                            .tracking(1)
                            .padding(.horizontal, 4).padding(.vertical, 2)
                            .background(LighthouseKeeperPalette.amber)
                            .foregroundColor(LighthouseKeeperPalette.teal)
                            .cornerRadius(3)
                    }
                }
                HStack(spacing: 4) {
                    FlagGlyph(nation: ship.flag, size: CGSize(width: 20, height: 12))
                    Text(ship.flag)
                        .font(.system(size: 11))
                        .foregroundColor(LighthouseKeeperPalette.inkMid)
                    Text("•")
                        .foregroundColor(LighthouseKeeperPalette.inkSoft)
                    Text(ship.kind.rawValue.capitalized)
                        .font(.system(size: 11))
                        .foregroundColor(LighthouseKeeperPalette.inkMid)
                }
                Text("\(ship.tonnage) tons • \(ship.originPort)")
                    .font(.system(size: 11))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
            }
            Spacer()
            if identified {
                CheckGlyph(size: 22, color: LighthouseKeeperPalette.teal)
            } else {
                XGlyph(size: 18, color: LighthouseKeeperPalette.inkSoft)
            }
            ChevronGlyph(direction: .right, size: 14, color: LighthouseKeeperPalette.inkSoft)
        }
        .padding(10)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(identified ? LighthouseKeeperPalette.teal.opacity(0.6) : LighthouseKeeperPalette.divider, lineWidth: 1))
    }
}

// MARK: - Ship Detail

struct ShipDetail: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    let ship: ShipRegistryEntry

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .top, endPoint: .bottom))
                        .frame(height: 130)
                    HStack {
                        ShipSilhouette(kind: ship.kind, color: LighthouseKeeperPalette.amber, size: CGSize(width: 140, height: 60))
                        Spacer()
                        VStack(alignment: .trailing) {
                            FlagGlyph(nation: ship.flag, size: CGSize(width: 60, height: 36))
                            Text(ship.flag)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(LighthouseKeeperPalette.sand)
                        }
                    }
                    .padding(14)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(ship.name)
                        .font(.system(size: 22, weight: .heavy, design: .serif))
                        .foregroundColor(LighthouseKeeperPalette.inkDark)
                    detailRow("Class", ship.kind.rawValue.capitalized)
                    detailRow("Tonnage", "\(ship.tonnage)")
                    detailRow("Origin Port", ship.originPort)
                    detailRow("Captain", ship.captainName)
                    detailRow("Suspicion", ship.suspicion.label)
                    detailRow("Identified?", store.state.identifiedShips.contains(ship.id) ? "Yes" : "No")
                    if ship.storyShip {
                        Text("This vessel recurs across multiple seasons. Its identification carries narrative weight.")
                            .font(.system(size: 12))
                            .foregroundColor(LighthouseKeeperPalette.inkMid)
                            .padding(10)
                            .background(LighthouseKeeperPalette.surfaceSunken)
                            .cornerRadius(6)
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
            }
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle(ship.name, displayMode: .inline)
    }

    private func detailRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label.uppercased())
                .font(.system(size: 11, weight: .bold))
                .tracking(1.5)
                .foregroundColor(LighthouseKeeperPalette.inkMid)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(LighthouseKeeperPalette.inkDark)
        }
        .padding(.vertical, 6)
        .overlay(LighthouseKeeperDivider(color: LighthouseKeeperPalette.divider).padding(.top, 30), alignment: .bottom)
    }
}
