//
//  QuickActionsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct QuickActionsView: View {
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.lg) {
            ActionButton(title: "Dividends", icon: TradeVisionImage(Image(.dividendCalendar), type: .buttonIcon), action: {})
            ActionButton(title: "IPOs", icon: TradeVisionImage(Image(.ipoCalendar), type: .buttonIcon), action: {})
            ActionButton(title: "Radar", icon: TradeVisionImage(Image(systemName: "scope"), type: .buttonIcon), action: {})
            ActionButton(title: "AI Picks", icon: TradeVisionImage(Image(.AI), type: .buttonIcon), action: {})
        }
    }

    struct ActionButton: View {
        let title: String
        let icon: TradeVisionImage
        let action: () -> Void

        var body: some View {
            TradeVisionLabelWithIcon(
                title,
                type: .subtitle,
                iconImage: icon,
                position: .top
            )
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tradeVisionCard()
            .contentShape(Rectangle())
            .onTapGesture {
                // Go to action
            }
        }
    }
}
