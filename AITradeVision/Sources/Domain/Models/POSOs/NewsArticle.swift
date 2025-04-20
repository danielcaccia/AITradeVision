//
//  NewsArticle.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

struct NewsArticle: Decodable {
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case content
        case url
        case urlToImage
        case publishedAt
        case sentiment
    }
    
    let source: NewsSource
    let author: String?
    let title: String
    let description: String?
    let content: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let sentiment: AverageSentiment?
}

struct NewsSource: Decodable {
    let id: String?
    let name: String
}
