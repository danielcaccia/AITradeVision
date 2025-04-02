//
//  StockManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

protocol StockManagerProtocol {
    func getStockPrice(for symbol: String) async -> StockDTO?
}

class StockManager: StockManagerProtocol {
    private let financeService: any FinanceServiceProtocol
    
    init(financeService: some FinanceServiceProtocol = FinanceService()) {
        self.financeService = financeService
    }
    
    func getStockPrice(for symbol: String) async -> StockDTO? {
        guard let stock = await financeService.fetchStockPrice(for: symbol) else { return nil }
        return StockDTO(from: stock)
    }
}
