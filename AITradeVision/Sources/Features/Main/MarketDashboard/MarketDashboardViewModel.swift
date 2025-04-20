//
//  MarketDashboardViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import SwiftUI

@MainActor
class MarketDashboardViewModel: ObservableObject {
    //MARK: - Properties
        
    @Published var marketIndexQuotes: [MarketIndexQuoteDTO] = []
    @Published var marketTrending: [MarketMoverDTO] = []
    @Published var marketMovers: MarketMoversDTO = MarketMoversDTO(gainers: [], losers: [])
    @Published var watchlist: [StockQuoteDTO] = []
    @Published var latestNews: [NewsArticleDTO] = []
    
    @Published var isLoadingSummary = false
    @Published var isLoadingMovers = false
    @Published var isLoadingWatchlist = false
    @Published var isLoadingLatestNews = false

    private let watchlistManager: WatchlistManager
    private let stockManager: any StockManagerProtocol
    private let marketIndexManager: any MarketIndexManagerProtocol
    private let newsManager: any NewsManagerProtocol
    
    var selectedNews: NewsArticleDTO?
    
    weak var appCoordinator: AppCoordinator?
    
    //MARK: - Init
    
    init(
        watchlistManager: WatchlistManager,
        stockManager: some StockManagerProtocol,
        marketIndexManager: some MarketIndexManagerProtocol,
        newsManager: some NewsManagerProtocol,
        appCoordinator: AppCoordinator? = nil
    ) {
        self.watchlistManager = watchlistManager
        self.stockManager = stockManager
        self.marketIndexManager = marketIndexManager
        self.newsManager = newsManager
        self.appCoordinator = appCoordinator
        
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.fetchIndexesQuotes(for: MarketIndex.allCases.map { $0.symbol })
                }
                group.addTask {
                    await self.fetchMarketMovers()
                }
                group.addTask {
                    await self.fetchWatchlist()
                }
                group.addTask {
                    await self.fetchLatestNews()
                }
            }
        }
    }
    
    //MARK: - Fetch Data
    
    private func fetchIndexesQuotes(for symbols: [String]) async {
        isLoadingSummary = true
        defer { isLoadingSummary = false }
        
        for symbol in symbols {
            if let quoteDTO = await marketIndexManager.fetchMarketIndexQuote(for: symbol) {
                marketIndexQuotes.append(quoteDTO)
            }
        }
    }
    
    private func fetchMarketMovers() async {
        isLoadingMovers = true
        defer { isLoadingMovers = false }
        
        marketTrending = await stockManager.fetchTrendingNow()
        marketMovers = await stockManager.fetchMarketMovers()
    }
    
    private func fetchWatchlist() async {
        isLoadingWatchlist = true
        defer { isLoadingWatchlist = false }
        
        var updatedWatchlist: [StockQuoteDTO] = []
        
        for symbol in watchlistManager.symbols {
            if let quote = await stockManager.getStockPrice(for: symbol) {
                updatedWatchlist.append(quote)
            }
        }
        
        watchlist = updatedWatchlist
    }
    
    func fetchLatestNews() async {
        isLoadingLatestNews = true
        defer { isLoadingLatestNews = false }
        
        latestNews = await newsManager.fetchLatestNews()
    }
    
    //MARK: - Watchlist Handlers
    
    func tryAddSymbol(_ symbol: String) {
        Task {
            await watchlistManager.add(symbol: symbol)
            await fetchWatchlist()
        }
    }
    
    func removeSymbol(_ symbol: String) {
        Task {
            watchlistManager.remove(symbol: symbol)
            await fetchWatchlist()
        }
    }
    
    //MARK: - Change Flow
    
    func goToSettings() {
        appCoordinator?.currentFlow = .settings
    }
    
    func logout() async {
        do {
            try await FirebaseAuthService().logout()
            
            await MainActor.run {
                appCoordinator?.currentFlow = .auth
            }
        } catch {
            print("Error trying to logout: \(error.localizedDescription)")
        }
    }
}
