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
            ActionButton(title: "Search", icon: "magnifyingglass", action: {})
            ActionButton(title: "News", icon: "newspaper", action: {})
            ActionButton(title: "Add", icon: "plus", action: {})
            ActionButton(title: "Explore", icon: "safari", action: {})
        }
    }

    struct ActionButton: View {
        let title: String
        let icon: String
        let action: () -> Void

        var body: some View {
            TradeVisionLabelWithIcon(
                title,
                type: .subtitle,
                iconImage: Image(systemName: icon),
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
