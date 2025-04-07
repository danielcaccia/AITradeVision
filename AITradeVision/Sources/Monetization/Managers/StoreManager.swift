//
//  StoreManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation
import StoreKit

@MainActor
class StoreManager: ObservableObject {
    static let shared = StoreManager()
    
    @Published var products: [Product] = []
    @Published var purchasedProductIDs: Set<String> = []
    @Published var isProUnlocked: Bool = false

    private let productIDs: [String] = [
        "UNLOCK_ALERTS_PRO",
        "REMOVE_ADS"
    ]
    
    private init() {
        Task {
            await requestProducts()
            await updatePurchasedProducts()
        }
    }

    /// Consult available products at App Store Connect
    func requestProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("❌ Falha ao buscar produtos: \(error)")
        }
    }

    /// Verify products already purchased
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                purchasedProductIDs.insert(transaction.productID)
                
                if transaction.productID == "UNLOCK_ALERTS_PRO" {
                    isProUnlocked = true
                } else if transaction.productID == "REMOVE_ADS" {
                    AdManager.shared.removeAds()
                }
            case .unverified:
                break
            }
        }
    }

    /// Start purchase process
    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    purchasedProductIDs.insert(transaction.productID)
                    
                    if transaction.productID == "UNLOCK_ALERTS_PRO" {
                        isProUnlocked = true
                    } else if transaction.productID == "REMOVE_ADS" {
                        AdManager.shared.removeAds()
                    }
                    
                    await transaction.finish()
                    
                    return true
                } else {
                    print("❌ Transação não verificada.")
                }
            case .userCancelled:
                print("⚠️ Compra cancelada pelo usuário.")
            default:
                break
            }
        } catch {
            print("❌ Erro durante compra: \(error)")
        }
        return false
    }
}
