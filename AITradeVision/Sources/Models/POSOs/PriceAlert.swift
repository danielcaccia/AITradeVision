//
//  PriceAlert.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import Foundation

struct PriceAlert: Identifiable, Codable, Equatable {
    var id: UUID
    let symbol: String
    let targetPrice: Double
    let isGreaterThan: Bool
    
    init(symbol: String, targetPrice: Double, isGreaterThan: Bool) {
        self.id = UUID()
        self.symbol = symbol
        self.targetPrice = targetPrice
        self.isGreaterThan = isGreaterThan
    }
}
