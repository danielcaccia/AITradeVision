//
//  MarketSummaryCardsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketSummaryCardsView: View {
    let items = [
        ("S&P 500", "+1.25%", true),
        ("Nasdaq", "-0.32%", false),
        ("Bitcoin", "$62,340", true),
        ("USD/BRL", "R$ 5,04", true)
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            TradeVisionHStack {
                ForEach(items, id: \.0) { item in
                    TradeVisionVStack(spacing: TradeVisionSpacing.xs) {
                        TradeVisionLabel(item.0, type: .title)
                        TradeVisionLabel(item.1, type: item.2 ? .positive : .negative)
                    }
                    .tradeVisionCard()
                }
            }
        }
    }
}
