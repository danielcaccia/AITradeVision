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
            }
            .padding()
        }
        .tradeNavigationBar(title: "AITradeVision")
        .withBackButton(backAction: { coordinator.route = .marketDashboard })
        .tradeVisionBackground(.primaryBackground)
    }
}
