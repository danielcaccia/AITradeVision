//
//  History.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 13/04/25.
//

import Foundation

struct History: Decodable {
    let symbol: String
    let displayName: String
    let historicQuotes: [HistoricQuote]
    
    init(from response: StockHistoryResponse) {
        self.symbol = response.symbol
        self.displayName = response.displayName
        self.historicQuotes = response.historicQuotes
    }
}

struct HistoricQuote: Decodable {
    enum CodingKeys: String, CodingKey {
        case date
        case openPrice = "open"
        case highPrice = "high"
        case lowPrice = "low"
        case closePrice = "close"
        case volume
    }
    
    let date: String
    let openPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let closePrice: Double
    let volume: Int
}
