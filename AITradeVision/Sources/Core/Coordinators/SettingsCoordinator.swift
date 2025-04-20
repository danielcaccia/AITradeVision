//
//  SettingsCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

@MainActor
final class SettingsCoordinator: Coordinator, ObservableObject {
    @Published var route: SettingsRoute = .settings
    
    private let errorHandler = NetworkingErrorHandler()
    
    weak var appCoordinator: AppCoordinator!
    
    enum SettingsRoute {
        case settings
        case updateEmail
        case preferences
        case language
    }
    
    func start() -> some View {
        SettingsContainerView()
            .environmentObject(self)
            .environmentObject(appCoordinator)
    }
    
    func switchToMainApp() {
        appCoordinator.currentFlow = .market
    }
    
    @ViewBuilder
    func buildCurrentView(for route: SettingsRoute) -> some View {
        switch route {
        case .settings:
            let viewModel = SettingsViewModel(coordinator: self, appCoordinator: appCoordinator)
            SettingsView()
                .environmentObject(viewModel)
        case .updateEmail:
            let viewModel = UpdateEmailViewModel(coordinator: self)
            UpdateEmailView()
                .environmentObject(viewModel)
        case .preferences:
            PreferencesView()
        case .language:
            LanguageSettingsView()
        }
    }
}
