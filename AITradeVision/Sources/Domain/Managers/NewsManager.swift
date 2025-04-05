//
//  NewsManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import Foundation

protocol NewsManagerProtocol {
    func fetchNews(for symbol: String) async -> [NewsArticleDTO]
}

class NewsManager: NewsManagerProtocol {
    private let newsService: any NewsServiceProtocol
    private let errorHandler: any ErrorHandler
    
    init(newsService: some NewsServiceProtocol = NewsService(), errorHandler: some ErrorHandler) {
        self.newsService = newsService
        self.errorHandler = errorHandler
    }
    
    func fetchNews(for symbol: String) async -> [NewsArticleDTO] {
        await Task.runWithHandlingArray({
            return try await self.newsService.fetchNews(for: symbol).map { NewsArticleDTO(from: $0) }
        }, errorHandler: errorHandler, context: "NewsManager.fetchNews")
    }
}
