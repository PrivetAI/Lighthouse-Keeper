import SwiftUI

/// Strict, theme-independent color palette. All colors hard-coded; we never
/// look up system semantic colors so light/dark mode cannot affect appearance.
enum LighthouseKeeperPalette {
    static let teal     = Color(red: 0.122, green: 0.263, blue: 0.341) // #1F4357 deep teal
    static let sand     = Color(red: 0.941, green: 0.902, blue: 0.824) // #F0E6D2 pale sand
    static let amber    = Color(red: 0.886, green: 0.718, blue: 0.396) // #E2B765 warm amber
    static let slate    = Color(red: 0.176, green: 0.239, blue: 0.271) // #2D3D45 slate
    static let rust     = Color(red: 0.706, green: 0.349, blue: 0.243) // #B4593E rust red

    // Convenience derivatives
    static let surface       = Color(red: 0.965, green: 0.937, blue: 0.871)
    static let surfaceSunken = Color(red: 0.918, green: 0.875, blue: 0.792)
    static let inkDark       = Color(red: 0.118, green: 0.137, blue: 0.157)
    static let inkMid        = Color(red: 0.314, green: 0.341, blue: 0.376)
    static let inkSoft       = Color(red: 0.502, green: 0.502, blue: 0.502)
    static let divider       = Color(red: 0.835, green: 0.792, blue: 0.722)

    static func seasonTint(_ season: Season) -> Color {
        switch season {
        case .spring: return Color(red: 0.580, green: 0.690, blue: 0.502)
        case .summer: return Color(red: 0.886, green: 0.718, blue: 0.396)
        case .autumn: return Color(red: 0.706, green: 0.349, blue: 0.243)
        case .winter: return Color(red: 0.557, green: 0.682, blue: 0.745)
        }
    }
}
