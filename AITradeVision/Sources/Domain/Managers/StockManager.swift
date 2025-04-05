//
//  StockManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

protocol StockManagerProtocol {
    func getStockPrice(for symbol: String) async -> StockQuoteDTO?
    func fetchStockHistory(for symbol: String) async -> [StockQuoteDTO]
}

class StockManager: StockManagerProtocol {
    private let financeService: any FinanceServiceProtocol
    private let errorHandler: any ErrorHandler
    
    init(financeService: some FinanceServiceProtocol = FinanceService(), errorHandler: some ErrorHandler) {
        self.financeService = financeService
        self.errorHandler = errorHandler
    }
    
    func getStockPrice(for symbol: String) async -> StockQuoteDTO? {
        await Task.runWithHandling({
            guard let stockQuote = try await self.financeService.fetchStockPrice(for: symbol) else { return nil }
                return StockQuoteDTO(from: stockQuote)
            }, errorHandler: errorHandler, context: "StockManager.getStockPrice")
    }
    
    func fetchStockHistory(for symbol: String) async -> [StockQuoteDTO] {
        await Task.runWithHandlingArray({
            return try await self.financeService.fetchStockHistory(for: symbol).map { StockQuoteDTO(from: $0) }
        }, errorHandler: errorHandler, context: "StockManager.fetchStockHistory")
    }
}
