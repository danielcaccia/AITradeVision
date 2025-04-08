//
//  Untitled.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI

private struct TradeVisionThemeKey: EnvironmentKey {
    static let defaultValue: TradeVisionThemeManager = TradeVisionThemeManager()
}

extension EnvironmentValues {
    var tradeVisionTheme: TradeVisionThemeManager {
        get { self[TradeVisionThemeKey.self] }
        set { self[TradeVisionThemeKey.self] = newValue }
    }
}
