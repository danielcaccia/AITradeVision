//
//  HistoryDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 13/04/25.
//

import Foundation

struct HistoryDTO: Identifiable, Equatable {
    let id: UUID
    let symbol: String
    let displayName: String
    let historicQuotes: [HistoricQuoteDTO]
    
    init(from history: History) {
        self.id = UUID()
        self.symbol = history.symbol
        self.displayName = history.displayName
        self.historicQuotes = history.historicQuotes
            .map { HistoricQuoteDTO(from: $0) }
            .sorted { $0.date < $1.date }
    }
}

struct HistoricQuoteDTO: Identifiable, Equatable {
    let id: UUID
    let date: String
    let openPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let closePrice: Double
    let volume: Int
    
    init(from historicQuote: HistoricQuote) {
        self.id = UUID()
        self.date = historicQuote.date
        self.openPrice = historicQuote.openPrice
        self.highPrice = historicQuote.highPrice
        self.lowPrice = historicQuote.lowPrice
        self.closePrice = historicQuote.closePrice
        self.volume = historicQuote.volume
    }
}
