//
//  MockFinanceService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation
@testable import AITradeVision

class MockFinanceService: FinanceServiceProtocol {
    var stockQuoteToReturn: StockQuote?
    var stockHistoryToReturn: [StockQuote] = []
    var shouldReturnError = false
    
    func fetchStockPrice(for symbol: String) async throws -> StockQuote? {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return stockQuoteToReturn
    }
    
    func fetchStockHistory(for symbol: String) async throws -> [StockQuote] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return stockHistoryToReturn
    }
}
