//
//  AverageSentiment.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 20/04/25.
//

import Foundation

struct AverageSentiment: Decodable {
    let label: Sentiment
    let positive: Double
    let neutral: Double
    let negative: Double
}

enum Sentiment: String, Decodable {
    case positive = "positive"
    case neutral = "neutral"
    case negative = "negative"
}
