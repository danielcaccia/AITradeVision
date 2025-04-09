//
//  WatchlistPreviewView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct WatchlistPreviewView: View {
    let watchlist = [
        ("AAPL", "$174.03", "+1.23%"),
        ("TSLA", "$220.12", "-2.10%"),
        ("GOOGL", "$138.55", "+0.45%")
    ]

    var body: some View {
        TradeVisionVStack(alignment: .leading) {
            TradeVisionLabel("Watchlist", type: .sectionHeader)
            
            ForEach(watchlist, id: \.0) { stock in
                TradeVisionHStack {
                    TradeVisionLabel(stock.0, type: .title)
                    Spacer()
                    TradeVisionLabel(stock.1, type: .title)
                    TradeVisionLabel(stock.2, type: stock.2.contains("-") ? .negative : .positive)
                }
                .padding(.vertical, TradeVisionSpacing.xs)
            }
            .tradeVisionCard()
        }
    }
}
