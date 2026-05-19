import SwiftUI

// MARK: - Tab Icons (pure Shape, no SF Symbols)

struct TowerIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            // Base platform
            var base = Path()
            base.addRect(CGRect(x: w * 0.18, y: h * 0.82, width: w * 0.64, height: h * 0.08))
            ctx.fill(base, with: .color(color))
            // Tower body
            var body = Path()
            body.move(to: CGPoint(x: w * 0.32, y: h * 0.82))
            body.addLine(to: CGPoint(x: w * 0.40, y: h * 0.30))
            body.addLine(to: CGPoint(x: w * 0.60, y: h * 0.30))
            body.addLine(to: CGPoint(x: w * 0.68, y: h * 0.82))
            body.closeSubpath()
            ctx.stroke(body, with: .color(color), lineWidth: max(1.2, w * 0.04))
            // Lantern
            var lantern = Path()
            lantern.addRect(CGRect(x: w * 0.37, y: h * 0.18, width: w * 0.26, height: h * 0.14))
            ctx.stroke(lantern, with: .color(color), lineWidth: max(1.2, w * 0.04))
            // Cap
            var cap = Path()
            cap.move(to: CGPoint(x: w * 0.34, y: h * 0.18))
            cap.addLine(to: CGPoint(x: w * 0.50, y: h * 0.06))
            cap.addLine(to: CGPoint(x: w * 0.66, y: h * 0.18))
            cap.closeSubpath()
            ctx.stroke(cap, with: .color(color), lineWidth: max(1.2, w * 0.04))
        }
        .frame(width: size, height: size)
    }
}

struct RegistryIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            // Book outline
            var outer = Path(roundedRect: CGRect(x: w * 0.12, y: h * 0.12, width: w * 0.76, height: h * 0.76), cornerSize: CGSize(width: 3, height: 3))
            ctx.stroke(outer, with: .color(color), lineWidth: max(1.2, w * 0.05))
            // Spine
            var spine = Path()
            spine.move(to: CGPoint(x: w * 0.50, y: h * 0.12))
            spine.addLine(to: CGPoint(x: w * 0.50, y: h * 0.88))
            ctx.stroke(spine, with: .color(color), lineWidth: max(1.0, w * 0.03))
            // Ruled lines
            for i in 0..<3 {
                let y = h * (0.30 + Double(i) * 0.18)
                var line = Path()
                line.move(to: CGPoint(x: w * 0.20, y: y))
                line.addLine(to: CGPoint(x: w * 0.44, y: y))
                ctx.stroke(line, with: .color(color), lineWidth: max(0.8, w * 0.02))
                var line2 = Path()
                line2.move(to: CGPoint(x: w * 0.56, y: y))
                line2.addLine(to: CGPoint(x: w * 0.80, y: y))
                ctx.stroke(line2, with: .color(color), lineWidth: max(0.8, w * 0.02))
            }
        }
        .frame(width: size, height: size)
    }
}

struct LetterIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            // Envelope outline
            var env = Path(roundedRect: CGRect(x: w * 0.10, y: h * 0.22, width: w * 0.80, height: h * 0.56), cornerSize: CGSize(width: 4, height: 4))
            ctx.stroke(env, with: .color(color), lineWidth: max(1.2, w * 0.05))
            // Flap
            var flap = Path()
            flap.move(to: CGPoint(x: w * 0.10, y: h * 0.22))
            flap.addLine(to: CGPoint(x: w * 0.50, y: h * 0.54))
            flap.addLine(to: CGPoint(x: w * 0.90, y: h * 0.22))
            ctx.stroke(flap, with: .color(color), lineWidth: max(1.2, w * 0.04))
        }
        .frame(width: size, height: size)
    }
}

struct JournalIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            var rect = Path(roundedRect: CGRect(x: w * 0.18, y: h * 0.10, width: w * 0.64, height: h * 0.80), cornerSize: CGSize(width: 4, height: 4))
            ctx.stroke(rect, with: .color(color), lineWidth: max(1.2, w * 0.05))
            // Bookmark
            var bm = Path()
            bm.move(to: CGPoint(x: w * 0.66, y: h * 0.10))
            bm.addLine(to: CGPoint(x: w * 0.66, y: h * 0.36))
            bm.addLine(to: CGPoint(x: w * 0.74, y: h * 0.30))
            bm.addLine(to: CGPoint(x: w * 0.82, y: h * 0.36))
            bm.addLine(to: CGPoint(x: w * 0.82, y: h * 0.10))
            ctx.stroke(bm, with: .color(color), lineWidth: max(1.0, w * 0.03))
            // Lines
            for i in 0..<3 {
                let y = h * (0.40 + Double(i) * 0.14)
                var line = Path()
                line.move(to: CGPoint(x: w * 0.28, y: y))
                line.addLine(to: CGPoint(x: w * 0.62, y: y))
                ctx.stroke(line, with: .color(color), lineWidth: max(0.8, w * 0.02))
            }
        }
        .frame(width: size, height: size)
    }
}

struct AlmanacIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            // Compass rose
            var outer = Path(ellipseIn: CGRect(x: w * 0.10, y: h * 0.10, width: w * 0.80, height: h * 0.80))
            ctx.stroke(outer, with: .color(color), lineWidth: max(1.2, w * 0.05))
            // Needle
            var n = Path()
            n.move(to: CGPoint(x: w * 0.50, y: h * 0.18))
            n.addLine(to: CGPoint(x: w * 0.58, y: h * 0.50))
            n.addLine(to: CGPoint(x: w * 0.50, y: h * 0.82))
            n.addLine(to: CGPoint(x: w * 0.42, y: h * 0.50))
            n.closeSubpath()
            ctx.stroke(n, with: .color(color), lineWidth: max(1.0, w * 0.03))
            // Center
            var c = Path(ellipseIn: CGRect(x: w * 0.46, y: h * 0.46, width: w * 0.08, height: h * 0.08))
            ctx.fill(c, with: .color(color))
        }
        .frame(width: size, height: size)
    }
}

struct SettingsIcon: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            let cx = w * 0.5, cy = h * 0.5
            var path = Path()
            for i in 0..<8 {
                let a = Double(i) * .pi / 4
                let r1 = w * 0.38
                let r2 = w * 0.30
                let x1 = cx + CGFloat(cos(a)) * r1
                let y1 = cy + CGFloat(sin(a)) * r1
                let x2 = cx + CGFloat(cos(a + .pi / 8)) * r2
                let y2 = cy + CGFloat(sin(a + .pi / 8)) * r2
                if i == 0 { path.move(to: CGPoint(x: x1, y: y1)) } else { path.addLine(to: CGPoint(x: x1, y: y1)) }
                path.addLine(to: CGPoint(x: x2, y: y2))
            }
            path.closeSubpath()
            ctx.stroke(path, with: .color(color), lineWidth: max(1.0, w * 0.03))
            var inner = Path(ellipseIn: CGRect(x: cx - w * 0.12, y: cy - w * 0.12, width: w * 0.24, height: w * 0.24))
            ctx.stroke(inner, with: .color(color), lineWidth: max(1.0, w * 0.03))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Ship Silhouettes

enum ShipSilhouetteKind: String, Codable, CaseIterable {
    case cargo, passenger, fishing, military, derelict, sail, yacht, tanker, steamer, ferry
}

struct ShipSilhouette: View {
    let kind: ShipSilhouetteKind
    let color: Color
    let size: CGSize

    var body: some View {
        Canvas { ctx, _ in
            let w = size.width, h = size.height
            switch kind {
            case .cargo:
                cargoPath(ctx: &ctx, w: w, h: h, color: color)
            case .passenger:
                passengerPath(ctx: &ctx, w: w, h: h, color: color)
            case .fishing:
                fishingPath(ctx: &ctx, w: w, h: h, color: color)
            case .military:
                militaryPath(ctx: &ctx, w: w, h: h, color: color)
            case .derelict:
                derelictPath(ctx: &ctx, w: w, h: h, color: color)
            case .sail:
                sailPath(ctx: &ctx, w: w, h: h, color: color)
            case .yacht:
                yachtPath(ctx: &ctx, w: w, h: h, color: color)
            case .tanker:
                tankerPath(ctx: &ctx, w: w, h: h, color: color)
            case .steamer:
                steamerPath(ctx: &ctx, w: w, h: h, color: color)
            case .ferry:
                ferryPath(ctx: &ctx, w: w, h: h, color: color)
            }
        }
        .frame(width: size.width, height: size.height)
    }

    private func cargoPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.05, y: h * 0.68))
        hull.addLine(to: CGPoint(x: w * 0.95, y: h * 0.68))
        hull.addLine(to: CGPoint(x: w * 0.88, y: h * 0.82))
        hull.addLine(to: CGPoint(x: w * 0.12, y: h * 0.82))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Containers
        for i in 0..<5 {
            let x = w * (0.12 + CGFloat(i) * 0.14)
            var c = Path(roundedRect: CGRect(x: x, y: h * 0.48, width: w * 0.10, height: h * 0.20), cornerSize: .zero)
            ctx.fill(c, with: .color(color.opacity(0.7)))
        }
        // Bridge
        var b = Path(roundedRect: CGRect(x: w * 0.78, y: h * 0.32, width: w * 0.12, height: h * 0.18), cornerSize: .zero)
        ctx.fill(b, with: .color(color))
    }

    private func passengerPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.04, y: h * 0.60))
        hull.addLine(to: CGPoint(x: w * 0.96, y: h * 0.60))
        hull.addLine(to: CGPoint(x: w * 0.85, y: h * 0.82))
        hull.addLine(to: CGPoint(x: w * 0.15, y: h * 0.82))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Tiered decks
        var deck1 = Path(roundedRect: CGRect(x: w * 0.10, y: h * 0.42, width: w * 0.80, height: h * 0.18), cornerSize: CGSize(width: 4, height: 4))
        ctx.fill(deck1, with: .color(color.opacity(0.85)))
        var deck2 = Path(roundedRect: CGRect(x: w * 0.20, y: h * 0.26, width: w * 0.60, height: h * 0.16), cornerSize: CGSize(width: 4, height: 4))
        ctx.fill(deck2, with: .color(color.opacity(0.7)))
        // Stacks
        var s1 = Path(CGRect(x: w * 0.40, y: h * 0.12, width: w * 0.08, height: h * 0.14))
        var s2 = Path(CGRect(x: w * 0.55, y: h * 0.12, width: w * 0.08, height: h * 0.14))
        ctx.fill(s1, with: .color(color))
        ctx.fill(s2, with: .color(color))
    }

    private func fishingPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.10, y: h * 0.66))
        hull.addCurve(to: CGPoint(x: w * 0.90, y: h * 0.66), control1: CGPoint(x: w * 0.30, y: h * 0.78), control2: CGPoint(x: w * 0.70, y: h * 0.78))
        hull.addLine(to: CGPoint(x: w * 0.78, y: h * 0.82))
        hull.addLine(to: CGPoint(x: w * 0.22, y: h * 0.82))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Cabin
        var cab = Path(CGRect(x: w * 0.42, y: h * 0.50, width: w * 0.30, height: h * 0.16))
        ctx.fill(cab, with: .color(color.opacity(0.85)))
        // Mast
        var mast = Path()
        mast.move(to: CGPoint(x: w * 0.32, y: h * 0.50))
        mast.addLine(to: CGPoint(x: w * 0.32, y: h * 0.18))
        ctx.stroke(mast, with: .color(color), lineWidth: max(1.0, w * 0.02))
        // Rigging
        var rig = Path()
        rig.move(to: CGPoint(x: w * 0.32, y: h * 0.20))
        rig.addLine(to: CGPoint(x: w * 0.60, y: h * 0.50))
        ctx.stroke(rig, with: .color(color.opacity(0.7)), lineWidth: max(0.8, w * 0.015))
    }

    private func militaryPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.02, y: h * 0.62))
        hull.addLine(to: CGPoint(x: w * 0.98, y: h * 0.62))
        hull.addLine(to: CGPoint(x: w * 0.92, y: h * 0.78))
        hull.addLine(to: CGPoint(x: w * 0.08, y: h * 0.78))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Turret
        var t = Path(CGRect(x: w * 0.20, y: h * 0.50, width: w * 0.16, height: h * 0.12))
        ctx.fill(t, with: .color(color))
        // Gun barrel
        var b = Path(CGRect(x: w * 0.36, y: h * 0.53, width: w * 0.20, height: h * 0.03))
        ctx.fill(b, with: .color(color))
        // Superstructure
        var ss = Path(CGRect(x: w * 0.50, y: h * 0.32, width: w * 0.30, height: h * 0.30))
        ctx.fill(ss, with: .color(color.opacity(0.85)))
        // Mast
        var mast = Path()
        mast.move(to: CGPoint(x: w * 0.65, y: h * 0.32))
        mast.addLine(to: CGPoint(x: w * 0.65, y: h * 0.10))
        ctx.stroke(mast, with: .color(color), lineWidth: max(1.0, w * 0.02))
    }

    private func derelictPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.10, y: h * 0.66))
        hull.addLine(to: CGPoint(x: w * 0.90, y: h * 0.72))
        hull.addLine(to: CGPoint(x: w * 0.80, y: h * 0.84))
        hull.addLine(to: CGPoint(x: w * 0.18, y: h * 0.82))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color.opacity(0.7)))
        // Broken mast
        var m = Path()
        m.move(to: CGPoint(x: w * 0.45, y: h * 0.66))
        m.addLine(to: CGPoint(x: w * 0.40, y: h * 0.32))
        m.addLine(to: CGPoint(x: w * 0.60, y: h * 0.40))
        ctx.stroke(m, with: .color(color), lineWidth: max(1.0, w * 0.02))
        // Tattered sail rags
        var r = Path()
        r.move(to: CGPoint(x: w * 0.55, y: h * 0.42))
        r.addLine(to: CGPoint(x: w * 0.72, y: h * 0.50))
        r.addLine(to: CGPoint(x: w * 0.60, y: h * 0.56))
        ctx.stroke(r, with: .color(color.opacity(0.6)), lineWidth: max(0.8, w * 0.015))
    }

    private func sailPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.18, y: h * 0.70))
        hull.addCurve(to: CGPoint(x: w * 0.82, y: h * 0.70), control1: CGPoint(x: w * 0.30, y: h * 0.84), control2: CGPoint(x: w * 0.70, y: h * 0.84))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Mast
        var mast = Path()
        mast.move(to: CGPoint(x: w * 0.50, y: h * 0.70))
        mast.addLine(to: CGPoint(x: w * 0.50, y: h * 0.10))
        ctx.stroke(mast, with: .color(color), lineWidth: max(1.0, w * 0.02))
        // Triangular sail
        var s = Path()
        s.move(to: CGPoint(x: w * 0.50, y: h * 0.12))
        s.addLine(to: CGPoint(x: w * 0.50, y: h * 0.68))
        s.addLine(to: CGPoint(x: w * 0.80, y: h * 0.68))
        s.closeSubpath()
        ctx.fill(s, with: .color(color.opacity(0.7)))
        // Jib
        var j = Path()
        j.move(to: CGPoint(x: w * 0.50, y: h * 0.18))
        j.addLine(to: CGPoint(x: w * 0.50, y: h * 0.66))
        j.addLine(to: CGPoint(x: w * 0.20, y: h * 0.66))
        j.closeSubpath()
        ctx.fill(j, with: .color(color.opacity(0.55)))
    }

    private func yachtPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.12, y: h * 0.66))
        hull.addLine(to: CGPoint(x: w * 0.88, y: h * 0.66))
        hull.addLine(to: CGPoint(x: w * 0.78, y: h * 0.80))
        hull.addLine(to: CGPoint(x: w * 0.20, y: h * 0.80))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Smooth cabin
        var cab = Path(roundedRect: CGRect(x: w * 0.30, y: h * 0.46, width: w * 0.50, height: h * 0.20), cornerSize: CGSize(width: 12, height: 12))
        ctx.fill(cab, with: .color(color.opacity(0.85)))
        var windows = Path()
        windows.move(to: CGPoint(x: w * 0.36, y: h * 0.56))
        windows.addLine(to: CGPoint(x: w * 0.74, y: h * 0.56))
        ctx.stroke(windows, with: .color(color.opacity(0.5)), lineWidth: max(0.8, w * 0.015))
    }

    private func tankerPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.04, y: h * 0.68))
        hull.addLine(to: CGPoint(x: w * 0.96, y: h * 0.68))
        hull.addLine(to: CGPoint(x: w * 0.92, y: h * 0.84))
        hull.addLine(to: CGPoint(x: w * 0.08, y: h * 0.84))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Two large cylindrical tanks
        var t1 = Path(roundedRect: CGRect(x: w * 0.10, y: h * 0.42, width: w * 0.36, height: h * 0.26), cornerSize: CGSize(width: 12, height: 12))
        var t2 = Path(roundedRect: CGRect(x: w * 0.50, y: h * 0.42, width: w * 0.36, height: h * 0.26), cornerSize: CGSize(width: 12, height: 12))
        ctx.fill(t1, with: .color(color.opacity(0.8)))
        ctx.fill(t2, with: .color(color.opacity(0.8)))
        // Bridge aft
        var b = Path(CGRect(x: w * 0.82, y: h * 0.22, width: w * 0.12, height: h * 0.20))
        ctx.fill(b, with: .color(color))
    }

    private func steamerPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.06, y: h * 0.64))
        hull.addLine(to: CGPoint(x: w * 0.94, y: h * 0.64))
        hull.addLine(to: CGPoint(x: w * 0.86, y: h * 0.82))
        hull.addLine(to: CGPoint(x: w * 0.14, y: h * 0.82))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Cabin
        var c = Path(CGRect(x: w * 0.20, y: h * 0.42, width: w * 0.60, height: h * 0.22))
        ctx.fill(c, with: .color(color.opacity(0.85)))
        // Tall single funnel
        var f = Path(CGRect(x: w * 0.45, y: h * 0.18, width: w * 0.10, height: h * 0.26))
        ctx.fill(f, with: .color(color))
        // Smoke puff outline
        var p = Path(ellipseIn: CGRect(x: w * 0.42, y: h * 0.10, width: w * 0.18, height: h * 0.10))
        ctx.stroke(p, with: .color(color.opacity(0.6)), lineWidth: max(0.8, w * 0.015))
    }

    private func ferryPath(ctx: inout GraphicsContext, w: CGFloat, h: CGFloat, color: Color) {
        var hull = Path()
        hull.move(to: CGPoint(x: w * 0.08, y: h * 0.62))
        hull.addLine(to: CGPoint(x: w * 0.92, y: h * 0.62))
        hull.addLine(to: CGPoint(x: w * 0.84, y: h * 0.80))
        hull.addLine(to: CGPoint(x: w * 0.16, y: h * 0.80))
        hull.closeSubpath()
        ctx.fill(hull, with: .color(color))
        // Long passenger cabin
        var c = Path(CGRect(x: w * 0.14, y: h * 0.36, width: w * 0.72, height: h * 0.26))
        ctx.fill(c, with: .color(color.opacity(0.85)))
        // Windows row
        for i in 0..<6 {
            let x = w * (0.18 + CGFloat(i) * 0.12)
            var win = Path(CGRect(x: x, y: h * 0.45, width: w * 0.08, height: h * 0.10))
            ctx.fill(win, with: .color(color.opacity(0.4)))
        }
        // Short funnel
        var f = Path(CGRect(x: w * 0.46, y: h * 0.22, width: w * 0.10, height: h * 0.16))
        ctx.fill(f, with: .color(color))
    }
}

// MARK: - Weather Glyphs

struct WeatherGlyph: View {
    let kind: WeatherKind
    let size: CGFloat
    let color: Color

    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            switch kind {
            case .clear:
                var c = Path(ellipseIn: CGRect(x: w * 0.30, y: h * 0.30, width: w * 0.40, height: h * 0.40))
                ctx.fill(c, with: .color(color))
                for i in 0..<8 {
                    let a = Double(i) * .pi / 4
                    var ray = Path()
                    let r1 = w * 0.30, r2 = w * 0.44
                    ray.move(to: CGPoint(x: w * 0.5 + CGFloat(cos(a)) * r1, y: h * 0.5 + CGFloat(sin(a)) * r1))
                    ray.addLine(to: CGPoint(x: w * 0.5 + CGFloat(cos(a)) * r2, y: h * 0.5 + CGFloat(sin(a)) * r2))
                    ctx.stroke(ray, with: .color(color), lineWidth: max(1.0, w * 0.04))
                }
            case .mist, .fog, .seaFret:
                for i in 0..<4 {
                    let y = h * (0.28 + Double(i) * 0.14)
                    var line = Path()
                    line.move(to: CGPoint(x: w * 0.14, y: y))
                    line.addLine(to: CGPoint(x: w * 0.86, y: y))
                    ctx.stroke(line, with: .color(color.opacity(0.8)), lineWidth: max(1.2, w * 0.05))
                }
            case .squall, .gale, .thunder:
                var cloud = Path()
                cloud.move(to: CGPoint(x: w * 0.16, y: h * 0.46))
                cloud.addCurve(to: CGPoint(x: w * 0.84, y: h * 0.46), control1: CGPoint(x: w * 0.16, y: h * 0.10), control2: CGPoint(x: w * 0.84, y: h * 0.10))
                cloud.addLine(to: CGPoint(x: w * 0.16, y: h * 0.46))
                ctx.fill(cloud, with: .color(color))
                // Lightning bolt for thunder, slanted rain for others
                if kind == .thunder {
                    var bolt = Path()
                    bolt.move(to: CGPoint(x: w * 0.50, y: h * 0.48))
                    bolt.addLine(to: CGPoint(x: w * 0.38, y: h * 0.72))
                    bolt.addLine(to: CGPoint(x: w * 0.50, y: h * 0.72))
                    bolt.addLine(to: CGPoint(x: w * 0.42, y: h * 0.92))
                    ctx.stroke(bolt, with: .color(color), lineWidth: max(1.4, w * 0.05))
                } else {
                    for i in 0..<4 {
                        let x = w * (0.24 + Double(i) * 0.16)
                        var rain = Path()
                        rain.move(to: CGPoint(x: x, y: h * 0.55))
                        rain.addLine(to: CGPoint(x: x - w * 0.06, y: h * 0.85))
                        ctx.stroke(rain, with: .color(color), lineWidth: max(1.0, w * 0.035))
                    }
                }
            case .snow, .blizzard:
                for i in 0..<3 {
                    for j in 0..<3 {
                        let cx = w * (0.22 + Double(i) * 0.28)
                        let cy = h * (0.22 + Double(j) * 0.28)
                        var cross = Path()
                        cross.move(to: CGPoint(x: cx - w * 0.06, y: cy))
                        cross.addLine(to: CGPoint(x: cx + w * 0.06, y: cy))
                        cross.move(to: CGPoint(x: cx, y: cy - w * 0.06))
                        cross.addLine(to: CGPoint(x: cx, y: cy + w * 0.06))
                        ctx.stroke(cross, with: .color(color), lineWidth: max(1.0, w * 0.03))
                    }
                }
            case .iceRain:
                for i in 0..<5 {
                    let x = w * (0.16 + Double(i) * 0.15)
                    var bar = Path()
                    bar.move(to: CGPoint(x: x, y: h * 0.18))
                    bar.addLine(to: CGPoint(x: x, y: h * 0.82))
                    ctx.stroke(bar, with: .color(color), lineWidth: max(1.0, w * 0.025))
                    var diamond = Path()
                    diamond.move(to: CGPoint(x: x, y: h * 0.46))
                    diamond.addLine(to: CGPoint(x: x + w * 0.04, y: h * 0.50))
                    diamond.addLine(to: CGPoint(x: x, y: h * 0.54))
                    diamond.addLine(to: CGPoint(x: x - w * 0.04, y: h * 0.50))
                    diamond.closeSubpath()
                    ctx.fill(diamond, with: .color(color))
                }
            case .doldrums:
                var c = Path(ellipseIn: CGRect(x: w * 0.30, y: h * 0.30, width: w * 0.40, height: h * 0.40))
                ctx.stroke(c, with: .color(color), lineWidth: max(1.2, w * 0.04))
                var inner = Path(ellipseIn: CGRect(x: w * 0.40, y: h * 0.40, width: w * 0.20, height: h * 0.20))
                ctx.fill(inner, with: .color(color.opacity(0.5)))
            case .aurora:
                for i in 0..<3 {
                    var wave = Path()
                    let yBase = h * (0.30 + Double(i) * 0.14)
                    wave.move(to: CGPoint(x: w * 0.08, y: yBase))
                    wave.addCurve(to: CGPoint(x: w * 0.92, y: yBase), control1: CGPoint(x: w * 0.30, y: yBase - h * 0.12), control2: CGPoint(x: w * 0.70, y: yBase + h * 0.12))
                    ctx.stroke(wave, with: .color(color.opacity(1.0 - Double(i) * 0.25)), lineWidth: max(1.2, w * 0.045))
                }
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Flag glyphs (abstract, 8 fictional nations)

struct FlagGlyph: View {
    let nation: String
    let size: CGSize
    var body: some View {
        let scheme = FlagGlyph.schemeFor(nation)
        let w = size.width
        let h = size.height
        ZStack {
            // Background field
            Rectangle().fill(scheme.0)
            // Pattern
            switch scheme.3 {
            case .horizontal:
                Rectangle().fill(scheme.1)
                    .frame(width: w, height: h / 3)
            case .vertical:
                Rectangle().fill(scheme.1)
                    .frame(width: w / 3, height: h)
            case .canton:
                ZStack(alignment: .topLeading) {
                    Color.clear
                    Rectangle().fill(scheme.1)
                        .frame(width: w * 0.45, height: h * 0.55)
                    Circle().fill(scheme.2)
                        .frame(width: w * 0.20, height: w * 0.20)
                        .offset(x: w * 0.10, y: h * 0.12)
                }
                .frame(width: w, height: h)
            case .saltire:
                FlagSaltireShape()
                    .stroke(scheme.1, lineWidth: max(2, h * 0.18))
                    .frame(width: w, height: h)
            case .circle:
                Circle().fill(scheme.1)
                    .frame(width: w * 0.36, height: w * 0.36)
            case .triangle:
                FlagTriangleShape()
                    .fill(scheme.1)
                    .frame(width: w, height: h)
            }
        }
        .frame(width: w, height: h)
        .overlay(Rectangle().stroke(LighthouseKeeperPalette.inkMid, lineWidth: 0.5))
        .clipped()
    }

    enum FlagPattern { case horizontal, vertical, canton, saltire, circle, triangle }

    static func schemeFor(_ nation: String) -> (Color, Color, Color, FlagPattern) {
        switch nation {
        case "Halverin":   return (Color(red: 0.122, green: 0.263, blue: 0.341), Color(red: 0.941, green: 0.902, blue: 0.824), Color(red: 0.886, green: 0.718, blue: 0.396), .horizontal)
        case "Kerstadt":   return (Color(red: 0.706, green: 0.349, blue: 0.243), Color(red: 0.941, green: 0.902, blue: 0.824), Color.white, .saltire)
        case "Norvalga":   return (Color(red: 0.176, green: 0.239, blue: 0.271), Color(red: 0.886, green: 0.718, blue: 0.396), Color.white, .canton)
        case "Briath":     return (Color(red: 0.580, green: 0.690, blue: 0.502), Color(red: 0.176, green: 0.239, blue: 0.271), Color.white, .vertical)
        case "Vossengard": return (Color(red: 0.557, green: 0.682, blue: 0.745), Color(red: 0.122, green: 0.263, blue: 0.341), Color.white, .triangle)
        case "Maremont":   return (Color(red: 0.941, green: 0.902, blue: 0.824), Color(red: 0.706, green: 0.349, blue: 0.243), Color(red: 0.122, green: 0.263, blue: 0.341), .circle)
        case "Tussolen":   return (Color(red: 0.886, green: 0.718, blue: 0.396), Color(red: 0.122, green: 0.263, blue: 0.341), Color.white, .horizontal)
        case "Olstrand":   return (Color(red: 0.122, green: 0.263, blue: 0.341), Color(red: 0.706, green: 0.349, blue: 0.243), Color(red: 0.941, green: 0.902, blue: 0.824), .vertical)
        default:           return (LighthouseKeeperPalette.slate, LighthouseKeeperPalette.sand, LighthouseKeeperPalette.amber, .horizontal)
        }
    }
}

// MARK: - Misc small icons

struct ChevronGlyph: View {
    let direction: ChevronDirection
    let size: CGFloat
    let color: Color
    enum ChevronDirection { case right, left, down, up }
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            var p = Path()
            switch direction {
            case .right:
                p.move(to: CGPoint(x: w * 0.35, y: h * 0.20))
                p.addLine(to: CGPoint(x: w * 0.65, y: h * 0.50))
                p.addLine(to: CGPoint(x: w * 0.35, y: h * 0.80))
            case .left:
                p.move(to: CGPoint(x: w * 0.65, y: h * 0.20))
                p.addLine(to: CGPoint(x: w * 0.35, y: h * 0.50))
                p.addLine(to: CGPoint(x: w * 0.65, y: h * 0.80))
            case .down:
                p.move(to: CGPoint(x: w * 0.20, y: h * 0.35))
                p.addLine(to: CGPoint(x: w * 0.50, y: h * 0.65))
                p.addLine(to: CGPoint(x: w * 0.80, y: h * 0.35))
            case .up:
                p.move(to: CGPoint(x: w * 0.20, y: h * 0.65))
                p.addLine(to: CGPoint(x: w * 0.50, y: h * 0.35))
                p.addLine(to: CGPoint(x: w * 0.80, y: h * 0.65))
            }
            ctx.stroke(p, with: .color(color), style: StrokeStyle(lineWidth: max(1.0, w * 0.08), lineCap: .round, lineJoin: .round))
        }
        .frame(width: size, height: size)
    }
}

struct CheckGlyph: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            var p = Path()
            p.move(to: CGPoint(x: w * 0.20, y: h * 0.52))
            p.addLine(to: CGPoint(x: w * 0.42, y: h * 0.74))
            p.addLine(to: CGPoint(x: w * 0.82, y: h * 0.28))
            ctx.stroke(p, with: .color(color), style: StrokeStyle(lineWidth: max(1.4, w * 0.10), lineCap: .round, lineJoin: .round))
        }
        .frame(width: size, height: size)
    }
}

struct XGlyph: View {
    let size: CGFloat
    let color: Color
    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width, h = sz.height
            var p = Path()
            p.move(to: CGPoint(x: w * 0.24, y: h * 0.24))
            p.addLine(to: CGPoint(x: w * 0.76, y: h * 0.76))
            p.move(to: CGPoint(x: w * 0.76, y: h * 0.24))
            p.addLine(to: CGPoint(x: w * 0.24, y: h * 0.76))
            ctx.stroke(p, with: .color(color), style: StrokeStyle(lineWidth: max(1.2, w * 0.10), lineCap: .round))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Flag pattern shapes

struct FlagSaltireShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return p
    }
}

struct FlagTriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX + rect.width * 0.55, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

// MARK: - Decorative dividers

struct LighthouseKeeperDivider: View {
    let color: Color
    var body: some View {
        HStack(spacing: 6) {
            Rectangle().fill(color.opacity(0.5)).frame(height: 1)
            Circle().fill(color.opacity(0.7)).frame(width: 4, height: 4)
            Rectangle().fill(color.opacity(0.5)).frame(height: 1)
        }
    }
}
