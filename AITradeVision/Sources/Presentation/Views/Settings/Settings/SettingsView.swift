//
//  SettingsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var viewModel: SettingsViewModel
    
    @State private var showingPaywall = false
    @State private var showRemoveAds = false
    
    @EnvironmentObject var coordinator: SettingsCoordinator
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("⚙️ Configurações")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Button("💸 Comprar") {
                showingPaywall = !showingPaywall
            }
            .buttonStyle(.bordered)
            
            Button("📢 Remover Anúncios") {
                showRemoveAds = !showRemoveAds
            }
            .buttonStyle(.bordered)
            
            Button("🔐 Alterar Email/Senha") {
                viewModel.goToUpdateEmail()
            }
            
            Button("🌙 Preferências de Exibição") {
                viewModel.goToPreferences()
            }
            
            Button("🌍 Idioma") {
                viewModel.goToLanguage()
            }
            
            Divider().padding(.vertical, 10)
            
            Button("Logout") {
                Task { await viewModel.logout() }
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
            Button("Voltar ao Dashboard") {
                viewModel.goToDashboard()
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingPaywall) {
            PaywallView()
        }
        .sheet(isPresented: $showRemoveAds) {
            RemoveAdsView()
        }
    }
}
