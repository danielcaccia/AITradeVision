//
//  SettingsCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

@MainActor
final class SettingsCoordinator: Coordinator, ObservableObject {
    @Published var route: SettingsRoute = .profile
    
    private let errorHandler = DefaultErrorHandler()
    
    enum SettingsRoute {
        case profile
        case preferences
    }
    
    func start() -> some View {
        SettingsContainerView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func buildCurrentView(for route: SettingsRoute) -> some View {
        switch route {
        case .profile:
            let viewModel = ProfileViewModel()
            ProfileView(viewModel: viewModel)
            
        case .preferences:
            let viewModel = PreferencesViewModel()
            PreferencesView(viewModel: viewModel)
        }
    }
}
