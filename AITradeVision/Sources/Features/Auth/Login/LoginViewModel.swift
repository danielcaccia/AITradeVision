//
//  LoginViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let authService: AuthServiceProtocol
    private let coordinator: AuthCoordinator

    init(authService: AuthServiceProtocol = FirebaseAuthService(), coordinator: AuthCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
    }

    func login() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await authService.login(email: email, password: password)
            coordinator.switchToMainApp()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
