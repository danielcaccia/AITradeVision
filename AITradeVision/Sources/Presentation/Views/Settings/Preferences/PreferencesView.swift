//
//  PreferencesView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject private var viewModel: PreferencesViewModel
    
    @EnvironmentObject var coordinator: SettingsCoordinator
    
    init(viewModel: PreferencesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Configurações")
                .font(.title)
            
            Button("Logout") {
                Task { await viewModel.logout() }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}
