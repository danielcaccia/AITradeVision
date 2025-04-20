//
//  MarketDashboardView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI
import TradeVisionUI

struct MarketDashboardView: View {
    @EnvironmentObject private var viewModel: MarketDashboardViewModel
    @EnvironmentObject var coordinator: MarketCoordinator
    
    @ObservedObject private var alertChecker: AlertChecker
    
    @State var showAddAlert = false
    
    init(alertChecker: AlertChecker) {
        self.alertChecker = alertChecker
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TradeVisionVStack(alignment: .leading) {
                    MarketHeaderView(title: "Market Dashboard")
                    MarketSummaryView(viewModel: viewModel)
                    MarketMoversView(viewModel: viewModel)
                    WatchlistView(viewModel: viewModel)
                    QuickActionsView()
                    MarketNewsView(viewModel: viewModel)
                }
                .padding()
            }
            .tradeNavigationBar(title: "AITradeVision")
            .withSettingsButton(action: viewModel.goToSettings)
            .tradeVisionBackground(.primaryBackground)
            .sheet(isPresented: $showAddAlert) {
                AddPriceAlertSheet()
            }
        }
    }
    
    private func toggleShowAddAlert() {
        showAddAlert = !showAddAlert
    }
}

//struct MarketDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarketDashboardView()
//    }
//}
