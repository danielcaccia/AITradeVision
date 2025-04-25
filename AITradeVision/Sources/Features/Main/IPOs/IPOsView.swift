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
                IPOsHeaderView(title: "Next IPOs")
            }
            .padding()
        }
        .tradeNavigationBar(title: "AITradeVision")
        .withBackButton(backAction: { coordinator.route = .marketDashboard })
        .tradeVisionBackground(.primaryBackground)
    }
}
