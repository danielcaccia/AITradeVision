//
//  SettingsCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

@MainActor
final class SettingsCoordinator: Coordinator, ObservableObject {
    @Published var route: SettingsRoute = .preferences
    
    private let errorHandler = DefaultErrorHandler()
    
    weak var appCoordinator: AppCoordinator!
    
    enum SettingsRoute {
        case preferences
        // futuros casos: profile, privacy, etc.
    }
    
    func start() -> some View {
        SettingsContainerView()
            .environmentObject(self)
            .environmentObject(appCoordinator)
    }
    
    @ViewBuilder
    func buildCurrentView(for route: SettingsRoute) -> some View {
        switch route {
        case .preferences:
            let viewModel = PreferencesViewModel(appCoordinator: appCoordinator)
            PreferencesView(viewModel: viewModel)
        }
    }
}
