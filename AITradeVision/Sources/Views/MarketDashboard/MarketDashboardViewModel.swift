//
//  StockViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

class StockViewModel: ObservableObject {
    @Published var stockPrices: [StockQuoteDTO] = []
    @Published var selectedStock: String? = nil

    private let stockManager: any StockManagerProtocol
    private let stockSymbols = ["AAPL", "TSLA", "DIS"]
    
    init(stockManager: some StockManagerProtocol = StockManager()) {
        self.stockManager = stockManager
        self.selectedStock = stockSymbols.randomElement()
        
        Task {
            await fetchStockPrices(for: stockSymbols)
        }
    }
    
    @MainActor
    private func fetchStockPrices(for symbols: [String]) async {
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
