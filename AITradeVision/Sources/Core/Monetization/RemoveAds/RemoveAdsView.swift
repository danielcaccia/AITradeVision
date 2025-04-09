//
//  RemoveAdsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import SwiftUI

struct RemoveAdsView: View {
    @StateObject private var viewModel = RemoveAdsViewModel()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text("🧹 Livre-se dos anúncios!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Eles ajudam a manter o app, mas você pode removê-los com uma compra única.")
                .multilineTextAlignment(.center)

            if let price = viewModel.removeAdsProduct?.displayPrice {
                Button {
                    Task {
                        await viewModel.buyRemoveAds()
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    } else {
                        Text("Remover Anúncios – \(price)")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
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
        }
        .padding()
        .navigationTitle("Remover Anúncios")
//        .onChange(of: viewModel.success) {
//            if viewModel.success {
//                dismiss()
//            }
//        }
    }
}
