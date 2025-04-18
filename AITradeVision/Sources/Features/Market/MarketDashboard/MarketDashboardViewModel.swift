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
    
    @Published var isLoadingSummary = false
    @Published var isLoadingMovers = false
    @Published var isLoadingWatchlist = false

    private let watchlistManager: WatchlistManager
    private let stockManager: any StockManagerProtocol
    private let marketIndexManager: any MarketIndexManagerProtocol
    
    weak var appCoordinator: AppCoordinator?
    
    //MARK: - Init
    
    init(
        watchlistManager: WatchlistManager,
        stockManager: some StockManagerProtocol,
        marketIndexManager: some MarketIndexManagerProtocol,
        appCoordinator: AppCoordinator? = nil
    ) {
        self.watchlistManager = watchlistManager
        self.stockManager = stockManager
        self.marketIndexManager = marketIndexManager
        self.appCoordinator = appCoordinator
        
        Task {
            await fetchIndexesQuotes(for: MarketIndex.allCases.map { $0.symbol })
            await fetchMarketMovers()
            await fetchWatchlist()
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
        
        for symbol in watchlistManager.symbols {
            if let quote = await stockManager.getStockPrice(for: symbol) {
                watchlist.append(quote)
            }
        }
    }
    
    //MARK: - Watchlist Handlers
    
    func tryAddSymbol(_ symbol: String) {
        Task {
            await watchlistManager.add(symbol: symbol)
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
