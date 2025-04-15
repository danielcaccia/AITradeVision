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
                    MarketSummaryCardsView(viewModel: viewModel)
                    MarketMoversView(viewModel: viewModel)
                    WatchlistPreviewView()
                    QuickActionsView()
                    MarketNewsView()
                }
                .padding()
            }
            .tradeVisionBackground(.primaryBackground)
            .tradeNavigationBar(title: "AITradeVision")
            .withSettingsButton(action: viewModel.goToSettings)
            .sheet(isPresented: $showAddAlert) {
                AddPriceAlertView()
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
