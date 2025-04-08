//
//  SettingsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: SettingsViewModel
    @EnvironmentObject var coordinator: SettingsCoordinator
    
    @State private var showingPaywall = false
    @State private var showRemoveAds = false
    
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

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
