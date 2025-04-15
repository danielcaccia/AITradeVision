//
//  MarketMoversView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketMoversView: View {
    @ObservedObject var viewModel: MarketDashboardViewModel
    @State private var selectedSection: MarketMoversSection = .trending
    
    var body: some View {
        TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
            TradeVisionVStack(alignment: .leading) {
                TradeVisionLabel("Market Movers", type: .sectionHeader)
                Picker("", selection: $selectedSection) {
                    ForEach(MarketMoversSection.allCases) { section in
                        TradeVisionLabel(section.title, type: .subtitle, alignment: .center).tag(section)
                    }
                }
                .frame(maxWidth: .infinity)
                .pickerStyle(.segmented)
            }
                        
            ScrollView(.horizontal, showsIndicators: false) {
                TradeVisionHStack {
                    if viewModel.isLoading {
                        marketMoverCard(mover: nil)
                        marketMoverCard(mover: nil)
                        marketMoverCard(mover: nil)
                    } else {
                        switch selectedSection {
                        case .trending:
                            ForEach(viewModel.marketTrending) { mover in
                                marketMoverCard(mover: mover)
                            }
                        case .gainers:
                            ForEach(viewModel.marketMovers.gainers) { mover in
                                marketMoverCard(mover: mover)
                            }
                        case .losers:
                            ForEach(viewModel.marketMovers.losers) { mover in
                                marketMoverCard(mover: mover)
                            }
                        }
                    }
                }
                .padding(.vertical, TradeVisionSpacing.xs)
            }
            .animation(.easeInOut(duration: 0.3), value: selectedSection)
        }
    }
    
    private func marketMoverCard(mover: MarketMoverDTO?) -> some View {
        TradeVisionHStack {
            TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.xs) {
                TradeVisionLabel(mover?.symbol ?? "Placeholder", type: .title)
                TradeVisionLabel(mover?.displayName ?? "Placeholder", type: .subtitle)
                    .lineLimit(1, reservesSpace: true)
                    .truncationMode(.tail)
            }
            TradeVisionLabel("\(mover?.variation.toString(decimals: 2) ?? "0.00")%", type: mover?.variation.labelType ?? .success, alignment: .trailing)
        }
        .frame(width: 220)
        .transition(.opacity.combined(with: .slide))
        .shimmering(isActive: viewModel.isLoading)
        .tradeVisionCard()
    }
}
