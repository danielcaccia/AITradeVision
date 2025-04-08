//
//  TradeVisionThemeManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI

public final class TradeVisionThemeManager: ObservableObject {
    @Published public var themeMode: ThemeMode

    public init(theme: ThemeMode = .dark) {
        self.themeMode = theme
    }

    public var current: TradeVisionTheme {
        switch themeMode {
        case .light:
            return TradeVisionTheme(
                primaryText: Color(hex: "0F1E36"),
                secondaryText: Color(hex: "5B6C85"),
                background: Color(hex: "F7F9FB"),
                cardBackground: Color(hex: "FFFFFF"),
                divider: Color(hex: "E0E6ED"),
                primaryBlue: Color(hex: "009CFF"),
                secondaryBlue: Color(hex: "00C6FF"),
                accent: Color(hex: "18C37D")
            )
        case .dark:
            return TradeVisionTheme(
                primaryText: Color(hex: "FFFFFF"),
                secondaryText: Color(hex: "A0AEC0"),
                background: Color(hex: "0B111A"),
                cardBackground: Color(hex: "1C2633"),
                divider: Color(hex: "2D3748"),
                primaryBlue: Color(hex: "0A84FF"),
                secondaryBlue: Color(hex: "1C3F61"),
                accent: Color(hex: "30D98D")
            )
        }
    }
}
