//
//  StockHistoryResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 04/04/25.
//

struct StockHistoryResponse: Decodable {
    let symbol: String
    let history: [HistoricQuote]
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
