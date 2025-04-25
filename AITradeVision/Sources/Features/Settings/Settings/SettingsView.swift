//
//  SettingsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI
import TradeVisionUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    @State private var showingPaywall = false
    @State private var showRemoveAds = false
    
    var body: some View {
        TradeVisionVStack(alignment: .leading) {
            Text("⚙️ Configurações")
                .multilineTextAlignment(.leading)
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
            
            TradeVisionButton(type: .primary("Logout")) {
                Task { await viewModel.logout() }
            }
            
            Spacer()
        }
        .padding()
        .tradeNavigationBar(title: "AITradeVision")
        .withBackButton(backAction: { viewModel.goToDashboard() })
        .tradeVisionBackground(.primaryBackground)
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
