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
    case fetchMarketMovers
    case fetchTrendingNow
    case fetchUpcomingDividends
    case fetchNews(symbol: String)
    case fetchLatestNews
    case analyzeSentiment
    
    var baseURL: String { "http://127.0.0.1:5001/" }

    var pathParameters: String {
        switch self {
        case .fetchStockPrice(let symbol):
            "quote?symbol=\(symbol)"
            
        case .fetchStockHistory(symbol: let symbol):
            "stock-history?symbol=\(symbol)"
            
        case .fetchMarketIndexQuote(let symbol):
            "index-quote?symbol=\(symbol)"
            
        case .fetchMarketMovers:
            "market-movers"
            
        case .fetchTrendingNow:
            "market-trending"
            
        case .fetchUpcomingDividends:
            "upcoming-dividends"
            
        case .fetchNews(symbol: let symbol):
            "stock-news?symbol=\(symbol)"
            
        case .fetchLatestNews:
            "latest-news"
            
        case .analyzeSentiment:
            "analyze"
        }
    }
}
