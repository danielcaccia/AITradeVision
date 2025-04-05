//
//  Sentiment.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import SwiftUI

enum Sentiment: String, Decodable {
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
}
