//
//  RegisterViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import Foundation
import FirebaseAuth

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let authService: AuthServiceProtocol
    private let coordinator: AuthCoordinator

    init(authService: AuthServiceProtocol = FirebaseAuthService(), coordinator: AuthCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
    }

    func register() async {
        guard password == confirmPassword else {
            errorMessage = "As senhas não coincidem."
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            coordinator.switchToMainApp()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func goBackToLogin() {
        coordinator.route = .login
    }
}
