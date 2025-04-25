//
//  StockDetailsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI
import TradeVisionUI

struct StockDetailsView: View {
    @EnvironmentObject private var viewModel: StockDetailsViewModel
    @EnvironmentObject var coordinator: MainCoordinator
        
    var body: some View {
        ScrollView {
            TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.md) {
                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.xs) {
                    TradeVisionLabel(viewModel.stock?.symbol ?? "N/A", type: .sectionHeader)
                    TradeVisionLabel(viewModel.stock?.displayName ?? "N/A", type: .subtitle)
                }

                TradeVisionHStack(alignment: .center, spacing: TradeVisionSpacing.sm) {
                    TradeVisionLabel(viewModel.stock?.latestPrice.toString(decimals: 2) ?? "N/A", type: .title)
                    TradeVisionLabel((viewModel.stock?.variation.toString(decimals: 2) ?? "N/A") + "%", type: viewModel.stock?.variation.labelType ?? .title)
                }

                Divider()

                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
                    stockDetailRow(title: "Open", value: viewModel.stock?.open)
                    stockDetailRow(title: "High", value: viewModel.stock?.dayHigh)
                    stockDetailRow(title: "Low", value: viewModel.stock?.dayLow)
                    stockDetailRow(title: "Volume", value: viewModel.stock?.latestVolume)
                }

                Spacer()
            }
            .padding()
        }
        .tradeNavigationBar(title: "\(viewModel.stock?.symbol ?? "N/A") Details")
        .withBackButton(backAction: { coordinator.route = .marketDashboard })
    }

    @ViewBuilder
    private func stockDetailRow(title: String, value: Double?) -> some View {
        TradeVisionHStack {
            TradeVisionLabel(title, type: .subtitle)
            Spacer()
            TradeVisionLabel(String(format: "%.2f", value ?? "N/A"), type: .subtitle)
        }
    }
}
