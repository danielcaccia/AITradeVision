//
//  RegisterView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject private var viewModel: RegisterViewModel
    
    @EnvironmentObject var coordinator: AuthCoordinator

    init(viewModel: RegisterViewModel) {
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
