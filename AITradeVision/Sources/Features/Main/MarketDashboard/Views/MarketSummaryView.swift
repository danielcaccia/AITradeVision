//
//  MarketSummaryView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketSummaryView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    @ObservedObject var viewModel: MarketDashboardViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            TradeVisionHStack {
                if viewModel.isLoadingSummary && viewModel.marketIndexQuotes.isEmpty {
                    marketSummaryCard(for: nil)
                    marketSummaryCard(for: nil)
                    marketSummaryCard(for: nil)
                } else {
                    ForEach(viewModel.marketIndexQuotes) { quote in
                        marketSummaryCard(for: quote)
                            .onTapGesture {
                                coordinator.route = .stockDetail(stockSymbol: quote.symbol)
                            }
                    }
                }
            }
            .padding(.vertical)
        }
    }
    
    private func marketSummaryCard(for quote: MarketIndexQuoteDTO?) -> some View {
        TradeVisionVStack(alignment: .center, spacing: TradeVisionSpacing.xs) {
            TradeVisionLabel(
                MarketIndex(rawValue: quote?.symbol ?? "Placeholder")?.friendlyDisplayName ?? quote?.symbol ?? "Placeholder",
                type: .title,
                alignment: .center
            )
            .minimumScaleFactor(0.5)
            TradeVisionLabel("\(quote?.variation.toString(decimals: 2) ?? "0.00")%", type: quote?.variation.labelType ?? .success, alignment: .center)
        }
        .frame(width: 100)
        .frame(maxHeight: .infinity)
        .tradeVisionCard()
        .shimmering(isActive: viewModel.isLoadingSummary && viewModel.marketIndexQuotes.isEmpty)
    }
}
