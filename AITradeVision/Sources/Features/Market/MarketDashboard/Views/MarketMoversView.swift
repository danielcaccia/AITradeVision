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
    
    @State private var selectedSection: MarketMoversSection = .gainers
    
    var body: some View {
        TradeVisionVStack(alignment: .leading) {
            TradeVisionHStack {
                TradeVisionLabel("Market Movers", type: .sectionHeader)
                Spacer()
                Picker("", selection: $selectedSection) {
                    ForEach(MarketMoversSection.allCases) { section in
                        Text(section.rawValue).tag(section)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, TradeVisionSpacing.sm)
            }
            
            TradeVisionVStack(spacing: TradeVisionSpacing.sm) {
                let isGainers = selectedSection == .gainers
                
                ScrollView(.horizontal, showsIndicators: false) {
                    TradeVisionHStack {
                        ForEach(isGainers ? gainers: losers, id: \.0) { item in
                            TradeVisionHStack {
                                TradeVisionVStack(alignment: .center, spacing: TradeVisionSpacing.xs) {
                                    TradeVisionLabel(item.0, type: .title)
                                    TradeVisionLabel("Nome da Empresa", type: .subtitle)
                                }
                                Spacer()
                                TradeVisionLabel(item.1, type: isGainers ? .success : .error)
                            }
                            .transition(.opacity.combined(with: .slide))
                            .tradeVisionCard()
                        }
                    }
                    .padding(.vertical)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: selectedSection)
        }
    }
}
