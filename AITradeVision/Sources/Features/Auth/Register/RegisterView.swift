//
//  RegisterView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var viewModel: RegisterViewModel
    @EnvironmentObject var coordinator: AuthCoordinator
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)

            SecureField("Senha", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            SecureField("Confirmar Senha", text: $viewModel.confirmPassword)
                .textFieldStyle(.roundedBorder)

            if viewModel.isLoading {
                ProgressView()
            }

            Button("Cadastrar") {
                Task { await viewModel.register() }
            }
            .disabled(viewModel.isLoading)

            Button("Voltar ao Login") {
                viewModel.goBackToLogin()
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
