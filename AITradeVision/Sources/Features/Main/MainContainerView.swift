//
//  MainContainerView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct MainContainerView: View {
    @EnvironmentObject var coordinator: MainCoordinator

    var body: some View {
        NavigationStack {
            RouteSwitcher(route: $coordinator.route) { route in
                coordinator.buildCurrentView(for: route)
            }
        }
    }
}
