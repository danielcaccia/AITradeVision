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
                VStack {
                    MarketHeaderView(title: "Market Dashboard", action: toggleShowAddAlert)
                    MarketSummaryCardsView()
                    MarketMoversView()
                    WatchlistPreviewView()
                    QuickActionsView()
                    MarketNewsView()
                }
                .padding()
            }
            .tradeVisionBackground(.primaryBackground).ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("AITradeVision")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: viewModel.goToSettings) {
                        Image(systemName: "gear")
                    }
                    .buttonStyle(TradeVisionIconButtonStyle())
                }
            }
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
