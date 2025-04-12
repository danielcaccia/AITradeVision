//
//  MarketNewsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketNewsView: View {
    let news = [
        "Federal Reserve signals pause on rate hikes.",
        "Tesla delivers record number of EVs in Q1.",
        "Bitcoin hits 65K amid crypto rally."
    ]

    var body: some View {
        TradeVisionVStack(alignment: .leading) {
            TradeVisionLabel("Latest News", type: .sectionHeader)

            TradeVisionVStack(spacing: TradeVisionSpacing.md) {
                ForEach(Array(news.enumerated()), id: \.0) { index, item in
                    TradeVisionHStack {
                        TradeVisionLabelWithIcon(
                            item,
                            type: .subtitle,
                            iconImage: Image(systemName: "newspaper")
                        )
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // Move to news
                    }
                    
                    if index < news.count - 1 {
                        TradeVisionDivider()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .tradeVisionCard()
        }
    }
}
