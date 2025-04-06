//
//  MarketContainerView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct MarketContainerView: View {
    @EnvironmentObject var coordinator: MarketCoordinator

    var body: some View {
        NavigationStack {
            RouteSwitcher(route: $coordinator.route) { route in
                coordinator.buildCurrentView(for: route)
            }
        }
    }
}
