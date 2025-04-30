//
//  RadarView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI
import TradeVisionUI

struct RadarView: View {
    @EnvironmentObject private var viewModel: RadarViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        ScrollView {
            TradeVisionVStack(alignment: .leading) {
                IPOsHeaderView(title: "Next IPOs")
                
                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
                    if viewModel.isLoadingSignals {
                        ProgressView("Carregando...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }  else if viewModel.signals.isEmpty {
                        TradeVisionLabel("No signals detected.", type: .subtitle, alignment: .center)
                            .padding()
                    } else {
                        ForEach(viewModel.signals) { signal in
                            TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
                                TradeVisionHStack {
                                    TradeVisionLabel(signal.symbol, type: .title)
                                    
                                    if let name = signal.name {
                                        TradeVisionLabel(name, type: .subtitle)
                                    }
                                }
                                
                                if let summary = signal.signalSummary {
                                    TradeVisionLabel(summary, type: .title, alignment: .leading)
                                }
                                
                                TradeVisionHStack {
                                    if let rsi = signal.rsi {
                                        TradeVisionLabel("RSI: \(rsi.toString(decimals: 1))", type: .subtitle)
                                    }
                                    TradeVisionLabel("Price: $\(signal.lastPrice.toString(decimals: 2))", type: .subtitle)
                                }
                            }
                            .tradeVisionCard()
                        }
                    }
                }
            }
            .padding()
        }
        .tradeNavigationBar(title: "AITradeVision")
        .withBackButton(backAction: { coordinator.route = .marketDashboard })
        .tradeVisionBackground(.primaryBackground)
    }
}
