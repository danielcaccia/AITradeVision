//
//  StockQuote.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

struct StockQuote: Decodable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case date
        case openPrice = "open"
        case highPrice = "high"
        case lowPrice = "low"
        case closePrice = "close"
        case volume
    }
    
    let symbol: String
    let date: String
    let openPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let closePrice: Double
    let volume: Int
    
    init(symbol: String, history: HistoricQuote) {
        self.symbol = symbol
        self.date = history.date
        self.openPrice = history.openPrice
        self.highPrice = history.highPrice
        self.lowPrice = history.lowPrice
        self.closePrice = history.closePrice
        self.volume = history.volume
    }
}
