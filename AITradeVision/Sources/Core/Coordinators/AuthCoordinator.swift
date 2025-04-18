//
//  AuthCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

@MainActor
final class AuthCoordinator: Coordinator, ObservableObject {
    @Published var route: AuthRoute = .login
    
    private let errorHandler = NetworkingErrorHandler()
    
    weak var appCoordinator: AppCoordinator!
    
    enum AuthRoute: Equatable {
        case login
        case register
    }
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func start() -> some View {
        AuthContainerView()
            .environmentObject(self)
            .environmentObject(appCoordinator)
    }
    
    func switchToMainApp() {
        appCoordinator.currentFlow = .market
    }
    
    @ViewBuilder
    func buildCurrentView(for route: AuthRoute) -> some View {
        switch route {
        case .login:
            let viewModel = LoginViewModel(coordinator: self)
            LoginView()
                .environmentObject(viewModel)
            
        case .register:
            let viewModel = RegisterViewModel(coordinator: self)
            RegisterView()
                .environmentObject(viewModel)
        }
    }
}
