//
//  FinanceService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

protocol FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async -> Stock?
}

class FinanceService: APIService, FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async -> Stock? {
        do {
            let response: StockResponse = try await self.request(endpoint: .fetchStockPrice(symbol: symbol), method: .get)
            return response.stock
        } catch let error as APIError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

struct StockResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case stock = "Global Quote"
    }
    
    let stock: Stock
}
