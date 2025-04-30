//
//  AIPicksView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI
import TradeVisionUI

struct AIPicksView: View {
    @EnvironmentObject private var viewModel: AIPicksViewModel
    @EnvironmentObject var coordinator: MainCoordinator
        
    var body: some View {
        ScrollView {
            TradeVisionVStack(alignment: .leading) {
                AIPicksHeaderView()
            }
            .padding()
        }
        .tradeNavigationBar(title: "AITradeVision")
        .withBackButton(backAction: { coordinator.route = .marketDashboard })
        .tradeVisionBackground(.primaryBackground)
    }
}
