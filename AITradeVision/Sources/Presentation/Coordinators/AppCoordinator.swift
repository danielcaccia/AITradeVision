//
//  AppCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import SwiftUI

@MainActor
protocol Coordinator: ObservableObject {
    associatedtype ContentView: View
    func start() -> ContentView
}

@MainActor
class AppCoordinator: ObservableObject {
    @Published var currentFlow: Flow = .market
    
    private let marketCoordinator = MarketCoordinator()
    private let authCoordinator = AuthCoordinator()
    private let settingsCoordinator = SettingsCoordinator()
    
    enum Flow {
        case market
        case auth
        case settings
    }
    
    @MainActor
    func viewForCurrentFlow() -> some View {
        switch currentFlow {
        case .market:
            return AnyView(
                marketCoordinator.start()
                    .environmentObject(self)
                    .environmentObject(marketCoordinator)
            )
        case .auth:
            return AnyView(
                authCoordinator.start()
                    .environmentObject(self)
                    .environmentObject(authCoordinator)
            )
        case .settings:
            return AnyView(
                settingsCoordinator.start()
                    .environmentObject(self)
                    .environmentObject(settingsCoordinator)
            )
        }
    }
}
