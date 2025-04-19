//
//  NewsArticle.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

struct NewsArticle: Decodable {
    let title: String
    let description: String?
    let content: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: String
}
