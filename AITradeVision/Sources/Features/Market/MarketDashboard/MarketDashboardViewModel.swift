//
//  MarketDashboardViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

@MainActor
class MarketDashboardViewModel: ObservableObject {
    @Published var marketIndexQuotes: [MarketIndexQuoteDTO] = []
    @Published var isLoading = false

    private let stockManager: any StockManagerProtocol
    private let marketIndexManager: any MarketIndexManagerProtocol
    
    weak var appCoordinator: AppCoordinator?
    
    init(
        stockManager: some StockManagerProtocol,
        marketIndexManager: some MarketIndexManagerProtocol,
        appCoordinator: AppCoordinator? = nil
    ) {
        self.stockManager = stockManager
        self.marketIndexManager = marketIndexManager
        self.appCoordinator = appCoordinator
        
        Task {
            await fetchIndexesQuotes(for: MarketIndex.allCases.map { $0.symbol })
        }
    }
    
    private func fetchIndexesQuotes(for symbols: [String]) async {
        isLoading = true
        defer { isLoading = false }
        
        for symbol in symbols {
            if let quoteDTO = await marketIndexManager.fetchMarketIndexQuote(for: symbol) {
                marketIndexQuotes.append(quoteDTO)
            }
        }
    }
    
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
            print("Erro ao deslogar: \(error.localizedDescription)")
        }
    }
}
