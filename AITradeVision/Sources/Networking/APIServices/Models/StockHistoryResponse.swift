//
//  StockHistoryResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 04/04/25.
//

struct StockHistoryResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case displayName = "display_name"
        case historicQuotes = "history"
    }
    
    let symbol: String
    let displayName: String
    let historicQuotes: [HistoricQuote]
}
