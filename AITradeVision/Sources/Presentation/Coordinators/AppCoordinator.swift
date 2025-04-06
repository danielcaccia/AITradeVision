//
//  AppCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import SwiftUI
import FirebaseAuth

@MainActor
protocol Coordinator: ObservableObject {
    associatedtype ContentView: View
    func start() -> ContentView
}

@MainActor
class AppCoordinator: ObservableObject {
    @Published var currentFlow: Flow = .auth
    
    private lazy var marketCoordinator = MarketCoordinator()
    private lazy var authCoordinator = AuthCoordinator(appCoordinator: self)
    private lazy var settingsCoordinator = SettingsCoordinator()
    
    enum Flow {
        case market
        case auth
        case settings
    }
    
    func checkAuthentication() {
        if Auth.auth().currentUser != nil {
            currentFlow = .market
        } else {
            currentFlow = .auth
        }
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
