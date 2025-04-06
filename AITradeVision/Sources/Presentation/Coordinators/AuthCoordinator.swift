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
    
    private let errorHandler = DefaultErrorHandler()
    
    enum AuthRoute: Equatable {
        case login
        case register
    }
    
    func start() -> some View {
        AuthContainerView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func buildCurrentView(for route: AuthRoute) -> some View {
        switch route {
        case .login:
            let viewModel = LoginViewModel()
            LoginView(viewModel: viewModel)
            
        case .register:
            let viewModel = RegisterViewModel()
            RegisterView(viewModel: viewModel)
        }
    }
}
