//
//  MarketMoversView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketMoversView: View {
    let gainers = [
        ("AAPL", "+3.12%"),
        ("NVDA", "+2.77%"),
        ("TSLA", "+2.30%")
    ]
    
    let losers = [
        ("NFLX", "-4.15%"),
        ("META", "-2.84%"),
        ("AMZN", "-1.93%")
    ]
    
    var body: some View {
        TradeVisionVStack(alignment: .leading) {
            TradeVisionLabel("Market Movers", type: .sectionHeader)
            
            TradeVisionHStack {
                TradeVisionVStack(alignment: .leading) {
                    TradeVisionLabelWithIcon(
                        "Top Gainers",
                        type: .title,
                        image: Image(systemName: "chart.line.uptrend.xyaxis"),
                        position: .right,
                        iconColor: .positive
                    )
                    
                    ForEach(gainers, id: \.0) { item in
                        TradeVisionHStack(spacing: TradeVisionSpacing.xs) {
                            TradeVisionLabel(item.0, type: .title)
                        }
                        
                        Spacer()
                        
                        TradeVisionLabel(item.1, type: .positive)
                    }
                }
                
                Spacer()
                
                TradeVisionVStack(alignment: .leading) {
                    TradeVisionLabelWithIcon(
                        "Top Losers",
                        type: .title,
                        image: Image(systemName: "chart.line.downtrend.xyaxis"),
                        position: .right,
                        iconColor: .negative
                    )
                    
                    ForEach(losers, id: \.0) { item in
                        TradeVisionHStack(spacing: TradeVisionSpacing.xs) {
                            TradeVisionLabel(item.0, type: .title)
                        }
                        
                        Spacer()
                        
                        TradeVisionLabel(item.1, type: .positive)
                    }
                }
            }
        }
    }
}
