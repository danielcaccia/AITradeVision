//
//  Endpoint.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

enum Endpoint {
    case fetchStockPrice(symbol: String)
    case fetchStockHistory(symbol: String)
    case fetchMarketIndexQuote(symbol: String)
    case fetchNews(symbol: String)
    case analyzeSentiment
    
    var baseURL: String {
        switch self {
        case .fetchStockPrice, .fetchStockHistory, .fetchMarketIndexQuote:
            "http://127.0.0.1:5001/"
        case .fetchNews(_):
            "https://newsapi.org/v2/"
        case .analyzeSentiment:
            "http://127.0.0.1:5001/"
        }
    }

    var pathParameters: String {
        switch self {
        case .fetchStockPrice(let symbol):
            return "quote?symbol=\(symbol)"
        case .fetchStockHistory(symbol: let symbol):
            return "stock-history?symbol=\(symbol)"
        case .fetchMarketIndexQuote(let symbol):
            return "index-quote?symbol=\(symbol)"
        case .fetchNews(symbol: let symbol):
            guard let apiKey = ProcessInfo.processInfo.environment["NEWS_API_ORG_API_KEY"] else { return "" }
            return "everything?q=\(symbol)&language=en&pageSize=10&apiKey=\(apiKey)"
        case .analyzeSentiment:
            return "analyze"
        }
    }
}
