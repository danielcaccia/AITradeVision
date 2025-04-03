//
//  SentimentPrediction.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

struct SentimentPrediction: Decodable {
    let label: String
    let score: Double
}
