//
//  StockDetailsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI
import TradeVisionUI

struct StockDetailsView: View {
    @EnvironmentObject private var viewModel: MarketDashboardViewModel
    @EnvironmentObject var coordinator: MarketCoordinator
    
    let stock: StockQuoteDTO
    
    var body: some View {
        ScrollView {
            TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.md) {
                // Header
                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.xs) {
                    TradeVisionLabel(stock.symbol, type: .sectionHeader)
                    TradeVisionLabel(stock.displayName, type: .subtitle)
                }

                // Price + Variation
                TradeVisionHStack(alignment: .center, spacing: TradeVisionSpacing.sm) {
                    TradeVisionLabel(stock.latestPrice.toString(decimals: 2), type: .title)
                    TradeVisionLabel("\(stock.variation.toString(decimals: 2))%", type: stock.variation.labelType)
                }

                Divider()

                // Details
                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
                    stockDetailRow(title: "Open", value: stock.open)
                    stockDetailRow(title: "High", value: stock.dayHigh)
                    stockDetailRow(title: "Low", value: stock.dayLow)
                    stockDetailRow(title: "Volume", value: stock.latestVolume)
                }

                Spacer()
            }
            .padding()
        }
        .tradeNavigationBar(title: "\(stock.symbol) Details")
        .withBackButton(backAction: { coordinator.route = .marketDashboard })
    }

    @ViewBuilder
    private func stockDetailRow(title: String, value: Double) -> some View {
        TradeVisionHStack {
            TradeVisionLabel(title, type: .subtitle)
            Spacer()
            TradeVisionLabel(String(format: "%.2f", value), type: .subtitle)
        }
    }
}
