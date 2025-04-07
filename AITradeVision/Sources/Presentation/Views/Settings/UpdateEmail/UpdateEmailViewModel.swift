//
//  UpdateEmailViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import FirebaseAuth

@MainActor
final class UpdateEmailViewModel: ObservableObject {
    @Published var newEmail = ""
    @Published var password = ""
    @Published var confirmationMessage: String?
    @Published var errorMessage: String?

    private weak var coordinator: SettingsCoordinator?

    init(coordinator: SettingsCoordinator?) {
        self.coordinator = coordinator
    }

    func updateEmail() async {
        guard let user = Auth.auth().currentUser,
              let email = user.email else {
            errorMessage = "Usuário inválido"
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)

        do {
            try await user.reauthenticate(with: credential)
            try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
            
            errorMessage = nil
            confirmationMessage = "Verifique seu email para confirmar a atualização."
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
