//
//  Endpoint.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

enum Endpoint {
    case fetchStockPrice(symbol: String)
    
    var baseURL: String {
        switch self {
        case .fetchStockPrice(_):
            "https://www.alphavantage.co/query"
        }
    }
    
    var pathParameters: String {
        switch self {
        case .fetchStockPrice(let symbol):
            guard let apiKey = ProcessInfo.processInfo.environment["ALPHA_VANTAGE_API_KEY"] else { return ""}
            return "?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=\(apiKey)"
        }
    }
}
