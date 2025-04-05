//
//  MarketDashboardViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

class MarketDashboardViewModel: ObservableObject {
    @Published var stockPrices: [StockQuoteDTO] = []
    @Published var selectedStock: String? = nil
    @Published var isLoading = false

    private let stockManager: any StockManagerProtocol
    private let stockSymbols = ["AAPL", "TSLA", "DIS"]
    
    init(stockManager: some StockManagerProtocol) {
        self.stockManager = stockManager
        self.selectedStock = stockSymbols.randomElement()
        
        Task {
            await fetchStockPrices(for: stockSymbols)
        }
    }
    
    @MainActor
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
}
