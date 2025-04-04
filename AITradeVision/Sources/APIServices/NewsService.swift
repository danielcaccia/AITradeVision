//
//  NewsService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews(for symbol: String) async -> [NewsArticle]
}

class NewsService: APIService, NewsServiceProtocol {
    func fetchNews(for symbol: String) async -> [NewsArticle] {
        do {
            let response: NewsResponse = try await self.request(endpoint: .fetchNews(symbol: symbol), method: .get)
            return response.articles
        } catch let error as APIError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
