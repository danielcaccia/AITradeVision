//
//  SentimentAnalysisService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

protocol SentimentAnalysisServiceProtocol {
    func analyzeSentiment(for text: String) async throws -> Sentiment?
}

class SentimentAnalysisService: APIService, SentimentAnalysisServiceProtocol {
    func analyzeSentiment(for text: String) async throws -> Sentiment? {
        let response: SentimentResponse = try await self.request(
            endpoint: .analyzeSentiment,
            method: .post,
            header: httpHeader(),
            body: httpBody(with: text)
        )
        return response.sentiment
    }
    
    private func httpHeader() -> HTTPHeader {
        guard let apiKey = ProcessInfo.processInfo.environment["PROSUS_AI_API_KEY"] else { return [:]}
        return [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]
    }

    private func httpBody(with text: String) -> HTTPBody {
        return ["text": text]
    }
}
