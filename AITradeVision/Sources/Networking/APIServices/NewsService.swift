//
//  NewsService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews(for symbol: String) async throws -> StockNews?
    func fetchLatestNews() async throws -> [NewsArticle]
}

class NewsService: APIService, NewsServiceProtocol {
    func fetchNews(for symbol: String) async throws -> StockNews? {
        let response: StockNews = try await self.request(endpoint: .fetchNews(symbol: symbol), method: .get)
        return response
    }
    
    func fetchLatestNews() async throws -> [NewsArticle] {
        let response: NewsResponse = try await self.request(endpoint: .fetchLatestNews, method: .get)
        return response.articles
    }
}
