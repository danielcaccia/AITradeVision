//
//  StockQuoteDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

struct StockQuoteDTO: Identifiable, Equatable {
    let id: UUID
    let symbol: String
    let displayName: String
    let open: Double
    let dayHigh: Double
    let dayLow: Double
    let latestPrice: Double
    let latestVolume: Double
    let variation: Double
    
    init(from stock: StockQuote) {
        self.id = UUID()
        self.symbol = stock.symbol
        self.displayName = stock.displayName ?? "N/A"
        self.open = stock.open
        self.dayHigh = stock.dayHigh
        self.dayLow = stock.dayLow
        self.latestPrice = stock.latestPrice
        self.latestVolume = stock.latestVolume
        self.variation = stock.variation
    }
}
