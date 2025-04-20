//
//  StockNews.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 20/04/25.
//

import Foundation

struct StockNews: Decodable {
    let averageSentiment: AverageSentiment
    let articles: [NewsArticle]
}
