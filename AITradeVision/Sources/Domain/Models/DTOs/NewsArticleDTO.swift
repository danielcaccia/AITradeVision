//
//  NewsArticleDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

struct NewsArticleDTO: Identifiable {
    let id: UUID
    let source: NewsSourceDTO
    let author: String?
    let title: String
    let description: String?
    let content: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String
    let sentiment: AverageSentimentDTO?
    
    init(from newsArticle: NewsArticle) {
        self.id = UUID()
        self.source = NewsSourceDTO(from: newsArticle.source)
        self.author = newsArticle.author
        self.title = newsArticle.title
        self.description = newsArticle.description
        self.content = newsArticle.content
        self.url = URL(string: newsArticle.url)
        self.urlToImage = URL(string: newsArticle.urlToImage ?? "")
        self.publishedAt = newsArticle.publishedAt
        self.sentiment = AverageSentimentDTO(from: newsArticle.sentiment)
    }
}

struct NewsSourceDTO {
    let id: String
    let name: String
    
    init(from newsSource: NewsSource) {
        self.id = newsSource.id ?? UUID().uuidString
        self.name = newsSource.name
    }
}
