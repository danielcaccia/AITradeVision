//
//  FinanceService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

protocol FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async -> StockQuote?
    func fetchStockHistory(for symbol: String) async -> [StockQuote]
}

class FinanceService: APIService, FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async -> StockQuote? {
        do {
            return try await self.request(endpoint: .fetchStockPrice(symbol: symbol), method: .get)
        } catch let error as APIError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func fetchStockHistory(for symbol: String) async -> [StockQuote] {
        do {
            let response: StockHistoryResponse = try await self.request(endpoint: .fetchStockHistory(symbol: symbol), method: .get)
            return response.history
                .map { StockQuote(symbol: response.symbol, history: $0) }
                .sorted { $0.date < $1.date }
        } catch let error as APIError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
