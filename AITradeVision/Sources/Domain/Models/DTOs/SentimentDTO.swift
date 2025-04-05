//
//  SentimentDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct SentimentDTO: Identifiable {
    let id: UUID
    let text: String
    let color: Color
    
    init(from sentiment: Sentiment) {
        self.id = UUID()
        self.text = sentiment.text
        self.color = sentiment.color
    }
}
