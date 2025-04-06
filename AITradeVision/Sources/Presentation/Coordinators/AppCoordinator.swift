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
    
    enum Flow {
        case market
        case login
        case settings
    }
    
    @MainActor
    func viewForCurrentFlow() -> some View {
        switch currentFlow {
        case .market:
            return marketCoordinator.start()
                .environmentObject(self)
                .environmentObject(marketCoordinator)
        case .login:
            return marketCoordinator.start()
                .environmentObject(self)
                .environmentObject(marketCoordinator)
        case .settings:
            return marketCoordinator.start()
                .environmentObject(self)
                .environmentObject(marketCoordinator)
        }
    }
}
