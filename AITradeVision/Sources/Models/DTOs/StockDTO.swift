//
//  StockDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

struct StockDTO: Identifiable {
    let id: UUID
    let symbol: String
    let price: Double
    
    init(from stock: Stock) {
        self.id = UUID()
        self.symbol = stock.symbol
        self.price = Double(stock.price) ?? 0.0
    }
}
