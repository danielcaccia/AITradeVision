//
//  NewsArticleDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

struct NewsArticleDTO: Identifiable {
    let id: UUID
    let title: String
    let description: String?
    let content: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: String
    
    
    
    init(from newsArticle: NewsArticle) {
        self.id = UUID()
        self.title = newsArticle.title
        self.description = newsArticle.description
        self.content = newsArticle.content
        self.url = newsArticle.url
        self.urlToImage = newsArticle.urlToImage
        self.publishedAt = newsArticle.publishedAt
    }
}
