//
//  UpdateEmailView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import SwiftUI

struct UpdateEmailView: View {
    @EnvironmentObject private var viewModel: UpdateEmailViewModel
    @EnvironmentObject var coordinator: SettingsCoordinator
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Novo Email", text: $viewModel.newEmail)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)

            SecureField("Senha Atual", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            if let confirmation = viewModel.confirmationMessage {
                Text(confirmation).foregroundColor(.green)
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }

            Button("Atualizar Email") {
                Task { await viewModel.updateEmail() }
            }

            Button("Voltar") {
                coordinator.route = .settings
            }

            Spacer()
        }
        .padding()
    }
}

//struct UpdateEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateEmailView()
//    }
//}
