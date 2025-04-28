//
//  IPOInfoDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 28/04/25.
//

import Foundation

struct IPOInfoDTO: Identifiable {
    let id: UUID
    let symbol: String
    let displayName: String
    let exchange: String
    let ipoDate: String
    let priceRange: Double
    
    init(from ipo: IPOInfo) {
        self.id = UUID()
        self.symbol = ipo.symbol
        self.displayName = ipo.displayName
        self.exchange = ipo.exchange
        self.ipoDate = ipo.ipoDate
        self.priceRange = ipo.priceRange
    }
}
