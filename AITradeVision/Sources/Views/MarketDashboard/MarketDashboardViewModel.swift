//
//  StockViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

class StockViewModel: ObservableObject {
    @Published var stockPrices: [StockDTO] = []
    
    private let stockManager: any StockManagerProtocol
    private let stockSymbols = ["AAPL", "TSLA", "DIS"]
    
    init(stockManager: some StockManagerProtocol = StockManager()) {
        self.stockManager = stockManager
        Task {
            await fetchStockPrices()
        }
    }
    
    @MainActor
    func fetchStockPrices() async {
        for symbol in stockSymbols {
            if let stockDTO = await stockManager.getStockPrice(for: symbol) {
                stockPrices.append(stockDTO)
            }
        }
    }
}
