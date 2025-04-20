//
//  AverageSentimentDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 20/04/25.
//

import SwiftUI

struct AverageSentimentDTO: Identifiable {
    let id: UUID
    let label: SentimentDTO
    let positiveScore: Double
    let neutralScore: Double
    let negativeScore: Double

    init(from average: AverageSentiment) {
        self.id = UUID()
        self.label = SentimentDTO(from: average.label) 
        self.positiveScore = average.positive
        self.neutralScore = average.neutral
        self.negativeScore = average.negative
    }
}

enum SentimentDTO: String, Decodable {
    case positive = "Positive"
    case neutral = "Neutral"
    case negative = "Negative"
    
    var text: String {
        switch self {
        case .positive: return "Mercado Otimista 📈"
        case .negative: return "Mercado Pessimista 📉"
        case .neutral: return "Mercado Neutro 😐"
        }
    }
    
    var color: Color {
        switch self {
        case .positive: return .green
        case .negative: return .red
        case .neutral: return .gray
        }
    }
    
    init(from sentiment: Sentiment) {
        switch sentiment {
        case .positive:
            self = .positive
        case .neutral:
            self = .neutral
        case .negative:
            self = .negative
        }
    }
}
