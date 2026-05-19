import SwiftUI

struct JournalView: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @State private var onlyBookmarked = false
    @State private var seasonFilter: Season? = nil

    var body: some View {
        VStack(spacing: 0) {
            filterBar
            ScrollView {
                LazyVStack(spacing: 10) {
                    if filtered.isEmpty {
                        emptyState
                    }
                    ForEach(filtered, id: \.id) { entry in
                        NavigationLink(destination: JournalEntryDetail(entry: entry)) {
                            row(entry)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(12)
            }
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle("Keeper's Journal", displayMode: .inline)
    }

    private var filtered: [JournalEntry] {
        var arr = store.state.journal
        if onlyBookmarked { arr = arr.filter { $0.bookmarked } }
        if let s = seasonFilter { arr = arr.filter { $0.season == s } }
        return arr.sorted { $0.nightIndex > $1.nightIndex }
    }

    private var filterBar: some View {
        VStack(spacing: 6) {
            HStack {
                Text("\(filtered.count) entries")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(1.5)
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                Spacer()
                Button { onlyBookmarked.toggle() } label: {
                    HStack(spacing: 4) {
                        if onlyBookmarked {
                            CheckGlyph(size: 14, color: LighthouseKeeperPalette.teal)
                        }
                        Text("Bookmarked")
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
                        seasonFilter = nil
                    } label: {
                        Text("All Seasons")
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(seasonFilter == nil ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.surfaceSunken)
                            .foregroundColor(seasonFilter == nil ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkDark)
                            .cornerRadius(4)
                    }
                    ForEach(Season.allCases, id: \.self) { s in
                        Button {
                            seasonFilter = (seasonFilter == s) ? nil : s
                        } label: {
                            Text(s.label)
                                .font(.system(size: 11, weight: .bold))
                                .padding(.horizontal, 8).padding(.vertical, 4)
                                .background(seasonFilter == s ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.surfaceSunken)
                                .foregroundColor(seasonFilter == s ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkDark)
                                .cornerRadius(4)
                        }
                    }
                }
            }
        }
        .padding(12)
        .background(LighthouseKeeperPalette.surfaceSunken)
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            JournalIcon(size: 40, color: LighthouseKeeperPalette.inkSoft)
            Text("No journal entries yet. Each completed night writes one.")
                .font(.system(size: 13))
                .foregroundColor(LighthouseKeeperPalette.inkMid)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
    }

    private func row(_ entry: JournalEntry) -> some View {
        HStack(spacing: 10) {
            VStack(spacing: 4) {
                Text("N\(entry.nightIndex + 1)")
                    .font(.system(size: 12, weight: .heavy))
                    .foregroundColor(LighthouseKeeperPalette.teal)
                WeatherGlyph(kind: entry.weather, size: 26, color: LighthouseKeeperPalette.amber)
            }
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(entry.season.label)
                        .font(.system(size: 10, weight: .bold))
                        .tracking(1.5)
                        .foregroundColor(LighthouseKeeperPalette.rust)
                    Text("•")
                        .foregroundColor(LighthouseKeeperPalette.inkSoft)
                    Text(entry.weather.label)
                        .font(.system(size: 11))
                        .foregroundColor(LighthouseKeeperPalette.inkMid)
                }
                Text(entry.summary)
                    .font(.system(size: 13))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                    .lineLimit(2)
            }
            Spacer()
            if entry.bookmarked {
                bookmarkIcon
            }
            ChevronGlyph(direction: .right, size: 14, color: LighthouseKeeperPalette.inkSoft)
        }
        .padding(10)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(entry.bookmarked ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.divider, lineWidth: 1))
    }

    private var bookmarkIcon: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            var p = Path()
            p.move(to: CGPoint(x: w * 0.20, y: h * 0.10))
            p.addLine(to: CGPoint(x: w * 0.80, y: h * 0.10))
            p.addLine(to: CGPoint(x: w * 0.80, y: h * 0.90))
            p.addLine(to: CGPoint(x: w * 0.50, y: h * 0.65))
            p.addLine(to: CGPoint(x: w * 0.20, y: h * 0.90))
            p.closeSubpath()
            ctx.fill(p, with: .color(LighthouseKeeperPalette.amber))
        }
        .frame(width: 16, height: 18)
    }
}

// MARK: - Journal Entry Detail

struct JournalEntryDetail: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    let entry: JournalEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                header
                summaryCard
                shipsCard
                eventsCard
                actionsRow
            }
            .padding(14)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle("Night \(entry.nightIndex + 1)", displayMode: .inline)
    }

    private var header: some View {
        HStack(spacing: 12) {
            WeatherGlyph(kind: entry.weather, size: 48, color: LighthouseKeeperPalette.amber)
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.season.label.uppercased())
                    .font(.system(size: 11, weight: .bold))
                    .tracking(2)
                    .foregroundColor(LighthouseKeeperPalette.amber)
                Text("Night \(entry.nightIndex + 1)")
                    .font(.system(size: 22, weight: .heavy, design: .serif))
                    .foregroundColor(LighthouseKeeperPalette.sand)
                Text("Weather: \(entry.weather.label)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.8))
            }
            Spacer()
        }
        .padding(14)
        .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(8)
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("SUMMARY").font(.system(size: 11, weight: .bold)).tracking(2).foregroundColor(LighthouseKeeperPalette.inkMid)
            Text(entry.summary)
                .font(.system(size: 14, design: .serif))
                .foregroundColor(LighthouseKeeperPalette.inkDark)
                .lineSpacing(4)
        }
        .padding(12).frame(maxWidth: .infinity, alignment: .leading)
        .background(LighthouseKeeperPalette.surfaceSunken).cornerRadius(8)
    }

    private var shipsCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("SHIPS PASSED").font(.system(size: 11, weight: .bold)).tracking(2).foregroundColor(LighthouseKeeperPalette.inkMid)
            if entry.ships.isEmpty {
                Text("No vessels sighted.").font(.system(size: 12)).foregroundColor(LighthouseKeeperPalette.inkMid)
            } else {
                ForEach(entry.ships, id: \.shipId) { s in
                    if let ship = LighthouseKeeperCatalog.ships.first(where: { $0.id == s.shipId }) {
                        HStack {
                            ShipSilhouette(kind: ship.kind, color: s.identified ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkSoft, size: CGSize(width: 50, height: 24))
                            VStack(alignment: .leading, spacing: 1) {
                                Text(s.identified ? ship.name : "(unidentified silhouette)")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(s.identified ? LighthouseKeeperPalette.inkDark : LighthouseKeeperPalette.inkMid)
                                if s.identified {
                                    Text("\(ship.flag) • hour \(s.hour + 1)")
                                        .font(.system(size: 11))
                                        .foregroundColor(LighthouseKeeperPalette.inkMid)
                                } else {
                                    Text("Hour \(s.hour + 1)")
                                        .font(.system(size: 11))
                                        .foregroundColor(LighthouseKeeperPalette.inkSoft)
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .padding(12)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
    }

    private var eventsCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("EVENTS").font(.system(size: 11, weight: .bold)).tracking(2).foregroundColor(LighthouseKeeperPalette.inkMid)
            if entry.events.isEmpty {
                Text("Quiet night.").font(.system(size: 12)).foregroundColor(LighthouseKeeperPalette.inkMid)
            } else {
                ForEach(entry.events, id: \.self) { e in
                    HStack(alignment: .top, spacing: 6) {
                        Text("•").foregroundColor(LighthouseKeeperPalette.rust)
                        Text(e).font(.system(size: 13)).foregroundColor(LighthouseKeeperPalette.inkDark)
                    }
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
    }

    private var actionsRow: some View {
        HStack {
            Button {
                store.toggleBookmark(entry.id)
            } label: {
                Text(entry.bookmarked ? "Remove Bookmark" : "Bookmark This Night")
                    .font(.system(size: 13, weight: .bold))
                    .padding(.horizontal, 14).padding(.vertical, 10)
                    .background(entry.bookmarked ? LighthouseKeeperPalette.slate : LighthouseKeeperPalette.amber)
                    .foregroundColor(entry.bookmarked ? LighthouseKeeperPalette.sand : LighthouseKeeperPalette.teal)
                    .cornerRadius(6)
            }
            Spacer()
        }
    }
}
