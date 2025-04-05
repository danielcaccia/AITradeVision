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
    let date: String
    let price: Double
    
    init(from stock: StockQuote) {
        self.id = UUID()
        self.date = stock.date
        self.symbol = stock.symbol
        self.price = Double(stock.closePrice)
    }
}
