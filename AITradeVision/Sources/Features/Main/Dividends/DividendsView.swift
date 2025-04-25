//
//  DividendsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI
import TradeVisionUI

struct DividendsView: View {
    @EnvironmentObject private var viewModel: DividendsViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        ScrollView {
            TradeVisionVStack(alignment: .leading) {
                DividendsHeaderView(title: "Next Dividends")
                
                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
                    if viewModel.isLoadingDividends {
                        ProgressView("Carregando...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }  else if viewModel.upcomingDividends.isEmpty {
                        TradeVisionLabel("No upcoming dividends distribution.", type: .subtitle, alignment: .center)
                            .padding()
                    } else {
                        ForEach(viewModel.upcomingDividends) { dividend in
                            TradeVisionHStack {
                                TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.xs) {
                                    TradeVisionLabel(dividend.symbol, type: .title)
                                    TradeVisionLabel("Data: \(dividend.dividendDate)", type: .subtitle)
                                }
                                Spacer()
                                TradeVisionLabel("$\(dividend.lastDividend.toString(decimals: 2))", type: .title)
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
