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
    private let stockSymbols = ["AAPL", "TSLA", "BTC-USD"]
    
    init(stockManager: some StockManagerProtocol = StockManager()) {
        self.stockManager = stockManager
        
        fetchStockPrices()
    }
    
    func fetchStockPrices() {
        for symbol in stockSymbols {
            stockManager.getStockPrice(for: symbol) { stockDTO in
                if let stockDTO = stockDTO {
                    DispatchQueue.main.async {
                        self.stockPrices.append(stockDTO)
                    }
                }
            }
        }
    }
}
