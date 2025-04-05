//
//  SentimentManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import Foundation

protocol SentimentManagerProtocol {
    func analyzeSentiment(for text: String) async -> SentimentDTO
}

class SentimentManager: SentimentManagerProtocol {
    private let sentimentAnalysisService: any SentimentAnalysisServiceProtocol
    private let errorHandler: any ErrorHandler
    
    init(sentimentAnalysisService: some SentimentAnalysisServiceProtocol = SentimentAnalysisService(), errorHandler: some ErrorHandler) {
        self.sentimentAnalysisService = sentimentAnalysisService
        self.errorHandler = errorHandler
    }
    
    func analyzeSentiment(for text: String) async -> SentimentDTO {
        await Task.runWithHandling({
            let sentiment = try await self.sentimentAnalysisService.analyzeSentiment(for: text)
            return SentimentDTO(from: sentiment ?? .neutral)
        }, errorHandler: errorHandler, context: "SentimentManager.analyzeSentiment") ?? SentimentDTO(from: .neutral)
    }
}
