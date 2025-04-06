//
//  LoginView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    
    @EnvironmentObject var coordinator: AuthCoordinator

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Login Screen")
            Button("Ir para Cadastro") {
                coordinator.route = .register
            }
        }
    }
}
