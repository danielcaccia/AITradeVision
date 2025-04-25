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
                RadarHeaderView(title: "Technical Radar")
            }
            .padding()
        }
        .tradeNavigationBar(title: "AITradeVision")
        .withBackButton(backAction: { coordinator.route = .marketDashboard })
        .tradeVisionBackground(.primaryBackground)
    }
}
