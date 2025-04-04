//
//  MarketSentimentViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

class MarketSentimentViewModel: ObservableObject {
    @Published var sentiment: Sentiment = .neutral
    @Published var isLoading = false
    
    private let newsService: any NewsServiceProtocol
    private let sentimentService: any SentimentAnalysisServiceProtocol
    
    init(
        newsService: some NewsServiceProtocol = NewsService(),
        sentimentService: some SentimentAnalysisServiceProtocol = SentimentAnalysisService()
    ) {
        self.newsService = newsService
        self.sentimentService = sentimentService
    }
    
    @MainActor
    func fetchMarketSentiment(for symbol: String) async {
        isLoading = true
        defer { isLoading = false }
        
        let articles = await newsService.fetchNews(for: symbol)
        let headlines = articles.map { $0.title.replacingOccurrences(of: "'", with: "’") }.joined(separator: " ")
        
        self.sentiment = await sentimentService.analyzeSentiment(for: headlines)
    }
}
