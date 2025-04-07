//
//  PaywallViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation
import StoreKit

@MainActor
class PaywallViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var purchaseSuccessful: Bool = false

    private let store = StoreManager.shared

    var proProduct: Product? {
        store.products.first { $0.id == "UNLOCK_ALERTS_PRO" }
    }

    var isProUser: Bool {
        store.isProUnlocked
    }

    func buyPro() async {
        guard let product = proProduct else {
            errorMessage = "Produto não encontrado."
            return
        }

        isLoading = true
        errorMessage = nil

        let success = await store.purchase(product)

        isLoading = false
        purchaseSuccessful = success

        if !success {
            errorMessage = "Não foi possível completar a compra."
        }
    }
}
