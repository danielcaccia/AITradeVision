//
//  StockChartViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 04/04/25.
//

import Foundation

class StockChartViewModel: ObservableObject {
    @Published var stockHistory: HistoryDTO?
    @Published var isLoading = false
    
    private let stockManager: any StockManagerProtocol

    init(stockManager: some StockManagerProtocol) {
        self.stockManager = stockManager
    }
    
    @MainActor
    func fetchStockHistory(for symbol: String) async {
        isLoading = true
        defer { isLoading = false }
        
        self.stockHistory = await stockManager.fetchStockHistory(for: symbol)
    }
}
