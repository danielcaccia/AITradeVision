//
//  NewsManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import Foundation

protocol NewsManagerProtocol {
    func fetchNews(for symbol: String) async -> StockNewsDTO?
    func fetchLatestNews() async -> [NewsArticleDTO]
}

class NewsManager: NewsManagerProtocol {
    private let newsService: any NewsServiceProtocol
    private let errorHandler: any ErrorHandler
    
    init(newsService: some NewsServiceProtocol = NewsService(), errorHandler: some ErrorHandler) {
        self.newsService = newsService
        self.errorHandler = errorHandler
    }
    
    func fetchNews(for symbol: String) async -> StockNewsDTO? {
        await Task.runWithHandling({
            guard let news = try await self.newsService.fetchNews(for: symbol) else { return nil }
            return StockNewsDTO(from: news, symbol: symbol)
        }, errorHandler: errorHandler, context: "NewsManager.fetchNews")
    }
    
    func fetchLatestNews() async -> [NewsArticleDTO] {
        await Task.runWithHandlingArray({
            return try await self.newsService.fetchLatestNews().map { NewsArticleDTO(from: $0) }
        }, errorHandler: errorHandler, context: "NewsManager.fetchLatestNews")
    }
}
