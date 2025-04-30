//
//  IPOsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI
import TradeVisionUI

struct IPOsView: View {
    @EnvironmentObject private var viewModel: IPOsViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        ScrollView {
            TradeVisionVStack(alignment: .leading) {
                IPOsHeaderView()
                
                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
                    if viewModel.isLoadingIPOs {
                        ProgressView("Carregando...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }  else if viewModel.upcomingIPOs.isEmpty {
                        TradeVisionLabel("No upcoming IPOs.", type: .subtitle, alignment: .center)
                            .padding()
                    } else {
                        ForEach(viewModel.upcomingIPOs) { ipo in
                            TradeVisionHStack {
                                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.xs) {
                                    TradeVisionLabel(ipo.symbol, type: .title)
                                    TradeVisionLabel("Data: \(ipo.ipoDate)", type: .subtitle)
                                }
                                Spacer()
                                TradeVisionLabel("\(ipo.priceRange.toString(decimals: 2))%", type: .title)
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
