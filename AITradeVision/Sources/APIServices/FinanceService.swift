//
//  FinanceService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

protocol FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String, completion: @escaping (Stock?) -> Void)
}

class FinanceService: APIService, FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String, completion: @escaping (Stock?) -> Void) {
        self.request(endpoint: .fetchStockPrice(symbol: symbol), method: .get) { (result: Result<StockResponse, Error>) in
            switch result {
            case .success(let stockResponse):
                if let stockInfo = stockResponse.quoteResponse.result.first {
                    let stock = Stock(symbol: stockInfo.symbol, marketPrice: stockInfo.marketPrice)
                    completion(stock)
                } else {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
}

struct StockResponse: Codable {
    let quoteResponse: QuoteResponse
}

struct QuoteResponse: Codable {
    let result: [Stock]
}
