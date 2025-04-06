//
//  AuthContainerView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct AuthContainerView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var coordinator: AuthCoordinator

    var body: some View {
        NavigationStack {
            RouteSwitcher(route: $coordinator.route) { route in
                coordinator.buildCurrentView(for: route)
            }
        }
    }
}
