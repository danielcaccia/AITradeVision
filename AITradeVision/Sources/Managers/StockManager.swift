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
    
    init(financeService: some FinanceServiceProtocol = FinanceService()) {
        self.financeService = financeService
    }
    
    func getStockPrice(for symbol: String) async -> StockQuoteDTO? {
        guard let stockQuote = await financeService.fetchStockPrice(for: symbol) else { return nil }
        return StockQuoteDTO(from: stockQuote)
    }
    
    func fetchStockHistory(for symbol: String) async -> [StockQuoteDTO] {
        return await financeService.fetchStockHistory(for: symbol).map { StockQuoteDTO(from: $0) }
    }
}
