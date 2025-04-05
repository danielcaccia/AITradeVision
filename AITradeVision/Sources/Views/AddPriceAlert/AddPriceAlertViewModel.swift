//
//  AddPriceAlertViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import Foundation

@MainActor
class AddPriceAlertViewModel: ObservableObject {
    @Published var symbol: String = ""
    @Published var targetPrice: String = ""
    @Published var isGreaterThan: Bool = true
    @Published var showError: Bool = false
    
    func createAlert(manager: PriceAlertManager) -> Bool {
        guard let price = Double(targetPrice), !symbol.isEmpty else {
            showError = true
            return false
        }
        
        let alert = PriceAlert(
            symbol: symbol.uppercased(),
            targetPrice: price,
            isGreaterThan: isGreaterThan
        )
        
        manager.addAlert(alert)
        return true
    }
}
