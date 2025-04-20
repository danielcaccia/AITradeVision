//
//  StrockNewsDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 20/04/25.
//

import Foundation

struct StockNewsDTO: Identifiable {
    let id: UUID
    let symbol: String
    let averageSentiment: AverageSentimentDTO?
    let articles: [NewsArticleDTO]
    
    init(from stockNews: StockNews, symbol: String) {
        self.id = UUID()
        self.symbol = symbol
        self.averageSentiment = AverageSentimentDTO(from: stockNews.averageSentiment)
        self.articles = stockNews.articles.map { NewsArticleDTO(from: $0) }
    }
}
