//
//  MarketSummaryCardsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketSummaryCardsView: View {
    @ObservedObject var viewModel: MarketDashboardViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            TradeVisionHStack {
                ForEach(viewModel.marketIndexQuotes) { quote in
                    TradeVisionVStack(alignment: .center, spacing: TradeVisionSpacing.xs) {
                        TradeVisionLabel(
                            MarketIndex(rawValue: quote.symbol)?.friendlyDisplayName ?? quote.symbol,
                            type: .title,
                            alignment: .center
                        )
                        .minimumScaleFactor(0.5)
                        TradeVisionLabel("\(quote.variation.toString(decimals: 2))%", type: quote.variation.labelType, alignment: .center)
                    }
                    .frame(width: 100)
                    .frame(maxHeight: .infinity)
                    .tradeVisionCard()
                    .shimmering(isActive: viewModel.isLoading)
                }
            }
            .padding(.vertical)
        }
    }
}
