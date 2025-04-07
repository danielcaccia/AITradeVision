//
//  RemoveAdsViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation
import StoreKit

@MainActor
class RemoveAdsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var success = false

    private let store = StoreManager.shared

    var removeAdsProduct: Product? {
        store.products.first { $0.id == "REMOVE_ADS" }
    }

    var adsAreRemoved: Bool {
        AdManager.shared.adsRemoved
    }

    func buyRemoveAds() async {
        isLoading = true
        defer { isLoading = false }
        
        guard let product = removeAdsProduct else {
            errorMessage = "Produto não encontrado."
            return
        }

        let result = await store.purchase(product)

        if result {
            AdManager.shared.removeAds()
            success = true
        } else {
            errorMessage = "Não foi possível completar a compra."
        }
    }
}
