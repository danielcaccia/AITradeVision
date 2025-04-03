//
//  FinanceService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

protocol FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async -> StockQuote?
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
}
