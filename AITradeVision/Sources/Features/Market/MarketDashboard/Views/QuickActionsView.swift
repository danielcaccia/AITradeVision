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
            ActionButton(title: "Search", icon: "magnifyingglass")
            ActionButton(title: "News", icon: "newspaper")
            ActionButton(title: "Add", icon: "plus")
            ActionButton(title: "Explore", icon: "safari")
        }
    }

    struct ActionButton: View {
        let title: String
        let icon: String

        var body: some View {
            TradeVisionLabelWithImage(
                title,
                type: .subtitle,
                image: Image(systemName: icon),
                position: .top
            )
            .frame(maxWidth: .infinity)
            .tradeVisionCard()
        }
    }
}
