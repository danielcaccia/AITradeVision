//
//  MarketDashboardViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

@MainActor
class MarketDashboardViewModel: ObservableObject {
    @Published var stockPrices: [StockQuoteDTO] = []
    @Published var selectedStock: String? = nil
    @Published var isLoading = false

    private let stockManager: any StockManagerProtocol
    private let stockSymbols = ["AAPL", "TSLA", "DIS"]
    
    weak var appCoordinator: AppCoordinator?
    
    init(stockManager: some StockManagerProtocol, appCoordinator: AppCoordinator? = nil) {
        self.stockManager = stockManager
        self.appCoordinator = appCoordinator
        self.selectedStock = stockSymbols.randomElement()
        
        Task {
            await fetchStockPrices(for: stockSymbols)
        }
    }
    
    private func fetchStockPrices(for symbols: [String]) async {
        isLoading = true
        defer { isLoading = false }
        
        for symbol in symbols {
            if let stockDTO = await stockManager.getStockPrice(for: symbol) {
                stockPrices.append(stockDTO)
            }
        }
    }
    
    func randomSymbol() -> String {
        return stockSymbols.randomElement() ?? "BA"
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
