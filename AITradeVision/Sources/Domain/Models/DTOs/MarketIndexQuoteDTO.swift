//
//  MarketIndexQuoteDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 12/04/25.
//

import Foundation

struct MarketIndexQuoteDTO: Identifiable, Equatable {
    let id: UUID
    let symbol: String
    let latestPrice: Double
    let variation: Double
    
    init(from quote: MarketIndexQuote) {
        self.id = UUID()
        self.symbol = quote.symbol
        self.latestPrice = quote.latestPrice
        self.variation = quote.variation
    }
}
