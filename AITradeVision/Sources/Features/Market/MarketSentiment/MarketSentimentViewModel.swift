//
//  MarketSentimentViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

class MarketSentimentViewModel: ObservableObject {
    @Published var sentiment: SentimentDTO?
    @Published var isLoading = false
    
    private let newsManager: any NewsManagerProtocol
    private let sentimentManager: any SentimentManagerProtocol
    
    init(
        newsManager: some NewsManagerProtocol,
        sentimentManager: some SentimentManagerProtocol
    ) {
        self.newsManager = newsManager
        self.sentimentManager = sentimentManager
    }
    
    @MainActor
    func fetchMarketSentiment(for symbol: String) async {
        isLoading = true
        defer { isLoading = false }
        
        let stockNews = await newsManager.fetchNews(for: symbol)
        let headlines = stockNews?.articles.map { $0.title.replacingOccurrences(of: "'", with: "’") }.joined(separator: " ")
        
        self.sentiment = await sentimentManager.analyzeSentiment(for: headlines ?? "")
    }
}
