//
//  StockManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

protocol StockManagerProtocol {
    func getStockPrice(for symbol: String) async -> StockQuoteDTO?
    func fetchStockHistory(for symbol: String) async -> HistoryDTO?
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
    
    func fetchStockHistory(for symbol: String) async -> HistoryDTO? {
        await Task.runWithHandling({
            guard let history = try await self.financeService.fetchStockHistory(for: symbol) else { return nil }
            return HistoryDTO(from: history)
        }, errorHandler: errorHandler, context: "StockManager.fetchStockHistory")
    }
}
