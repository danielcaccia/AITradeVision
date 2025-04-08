//
//  FinanceService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

protocol FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async throws -> StockQuote?
    func fetchStockHistory(for symbol: String) async throws -> [StockQuote]
}

class FinanceService: APIService, FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async throws -> StockQuote? {
        return try await self.request(endpoint: .fetchStockPrice(symbol: symbol), method: .get)
    }
    
    func fetchStockHistory(for symbol: String) async throws -> [StockQuote] {
        let response: StockHistoryResponse = try await self.request(endpoint: .fetchStockHistory(symbol: symbol), method: .get)
        return response.history
            .map { StockQuote(symbol: response.symbol, displayName: response.displayName, history: $0) }
            .sorted { $0.date < $1.date }
    }
}
