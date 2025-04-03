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
    
    init(from newsArticle: NewsArticle) {
        self.id = UUID()
        self.title = newsArticle.title
        self.description = newsArticle.description
    }
}
