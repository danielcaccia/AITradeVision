//
//  MockSentimentAnalysisService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation
@testable import AITradeVision

class MockSentimentAnalysisService: SentimentAnalysisServiceProtocol {
    var sentimentToReturn: Sentiment?
    var shouldReturnError = false
    
    func analyzeSentiment(for text: String) async throws -> Sentiment? {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return sentimentToReturn
    }
}
