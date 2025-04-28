//
//  FinanceService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

protocol FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async throws -> StockQuote?
    func fetchStockHistory(for symbol: String) async throws -> History?
    func fetchMarketIndexQuote(for symbol: String) async throws -> MarketIndexQuote?
    func fetchMarketMovers() async throws -> MarketMovers
    func fetchTrendingNow() async throws -> [MarketMover]
    func fetchUpcomingDividends() async throws -> [DividendInfo]
    func fetchUpcomingIPOs() async throws -> [IPOInfo]
}

class FinanceService: APIService, FinanceServiceProtocol {
    func fetchStockPrice(for symbol: String) async throws -> StockQuote? {
        return try await self.request(endpoint: .fetchStockPrice(symbol: symbol), method: .get)
    }
    
    func fetchStockHistory(for symbol: String) async throws -> History? {
        let response: StockHistoryResponse = try await self.request(endpoint: .fetchStockHistory(symbol: symbol), method: .get)
        return History(from: response)
    }
    
    func fetchMarketIndexQuote(for symbol: String) async throws -> MarketIndexQuote? {
        return try await self.request(endpoint: .fetchMarketIndexQuote(symbol: symbol), method: .get)
    }
    
    func fetchMarketMovers() async throws -> MarketMovers {
        let response: MarketMoversResponse = try await self.request(endpoint: .fetchMarketMovers, method: .get)
        return MarketMovers(gainers: response.gainers, losers: response.losers)
    }
    
    func fetchTrendingNow() async throws -> [MarketMover] {
        let response: MarketTrendingResponse = try await self.request(endpoint: .fetchTrendingNow, method: .get)
        return response.trending
    }
    
    func fetchUpcomingDividends() async throws -> [DividendInfo] {
        let response: UpcomingDividendsResponse = try await self.request(endpoint: .fetchUpcomingDividends, method: .get)
        return response.upcomingDividends
    }
    
    func fetchUpcomingIPOs() async throws -> [IPOInfo] {
        let response: UpcomingIPOsResponse = try await self.request(endpoint: .fetchUpcomingIPOs, method: .get)
        return response.upcomingIPOs
    }
}
