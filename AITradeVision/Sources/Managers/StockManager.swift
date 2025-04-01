//
//  StockManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

protocol StockManagerProtocol {
    func getStockPrice(for symbol: String, completion: @escaping (StockDTO?) -> Void)
}

class StockManager: StockManagerProtocol {
    private let financeService: any FinanceServiceProtocol
    
    init(financeService: some FinanceServiceProtocol = FinanceService()) {
        self.financeService = financeService
    }
    
    func getStockPrice(for symbol: String, completion: @escaping (StockDTO?) -> Void) {
        financeService.fetchStockPrice(for: symbol) { stock in
            if let stock = stock {
                let stockDTO = StockDTO(from: stock)
                completion(stockDTO)
            } else {
                completion(nil)
            }
        }
    }
}
