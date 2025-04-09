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

            ForEach(news, id: \.self) { item in
                TradeVisionHStack {
                    TradeVisionLabelWithImage(item, type: .subtitle, image: Image(systemName: "newspaper"))
                }
            }
        }
        .tradeVisionCard()
    }
}
