//
//  StockDetailsViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import Foundation

class StockDetailsViewModel: ObservableObject {
    @Published var stockHistory: HistoryDTO?
    @Published var isLoading = false
    
    private let symbol: String
    private let stockManager: any StockManagerProtocol
    
    init(symbol: String, stockManager: some StockManagerProtocol) {
        self.symbol = symbol
        self.stockManager = stockManager
        
        Task {
            await fetchStockHistory(for: symbol)
        }
    }
    
    @MainActor
    private func fetchStockHistory(for symbol: String) async {
        isLoading = true
        defer { isLoading = false }
        
        self.stockHistory = await stockManager.fetchStockHistory(for: symbol)
    }
}
