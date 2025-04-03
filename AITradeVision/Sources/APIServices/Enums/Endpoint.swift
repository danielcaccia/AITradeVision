//
//  Endpoint.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

enum Endpoint {
    case fetchStockPrice(symbol: String)
    case fetchNews(symbol: String)
    case analyzeSentiment
    
    var baseURL: String {
        switch self {
        case .fetchStockPrice(_):
            "http://127.0.0.1:5001/quote"
        case .fetchNews(_):
            "https://newsapi.org/v2/everything"
        case .analyzeSentiment:
            "http://127.0.0.1:5001/analyze"
        }
    }

    var pathParameters: String {
        switch self {
        case .fetchStockPrice(let symbol):
            return "?symbol=\(symbol)"
        case .fetchNews(symbol: let symbol):
            guard let apiKey = ProcessInfo.processInfo.environment["NEWS_API_ORG_API_KEY"] else { return "" }
            return "?q=\(symbol)&language=en&pageSize=10&apiKey=\(apiKey)"
        case .analyzeSentiment:
            return ""
        }
    }
}
