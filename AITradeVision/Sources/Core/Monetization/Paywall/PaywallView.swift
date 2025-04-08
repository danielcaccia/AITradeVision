//
//  PaywallView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import SwiftUI
import StoreKit

struct PaywallView: View {
    @StateObject private var viewModel = PaywallViewModel()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("🚀 Desbloqueie o Finance AI Pro")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 12) {
                    featureRow(icon: "bell.badge.fill", text: "Alertas ilimitados")
                    featureRow(icon: "clock.arrow.circlepath", text: "Verificações automáticas em segundo plano")
                    featureRow(icon: "brain.head.profile", text: "Análises com IA em tempo real")
                    featureRow(icon: "shield.checkerboard", text: "Sem anúncios e com prioridade de suporte")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                if let price = viewModel.proProduct?.displayPrice {
                    Button {
                        Task {
                            await viewModel.buyPro()
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                        } else {
                            Text("Desbloquear Pro por \(price)")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                Spacer()
                Button("Restaurar Compras") {
                    Task {
                        await StoreManager.shared.updatePurchasedProducts()
                    }
                }
                .font(.footnote)
            }
            .padding()
            .navigationTitle("Pro")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
            .onChange(of: viewModel.purchaseSuccessful) {
                if viewModel.purchaseSuccessful {
                    dismiss()
                }
            }
        }
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)
            Text(text)
        }
    }
}

//struct PaywallView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaywallView()
//    }
//}
