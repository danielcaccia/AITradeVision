//
//  StockDetailsViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import Foundation

@MainActor
class StockDetailsViewModel: ObservableObject {
    @Published var stock: StockQuoteDTO?
    @Published var stockHistory: HistoryDTO?
    
    @Published var isLoadingStock = false
    @Published var isLoadingHistory = false
    
    private let symbol: String
    private let stockManager: any StockManagerProtocol
    
    init(symbol: String, stockManager: some StockManagerProtocol) {
        self.symbol = symbol
        self.stockManager = stockManager
        
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.fetchStockQuote(for: symbol)
                }
                group.addTask {
                    await self.fetchStockHistory(for: symbol)
                }
            }
        }
    }
    
    private func fetchStockQuote(for symbol: String) async {
        isLoadingStock = true
        defer { isLoadingStock = false }
        
        stock = await stockManager.getStockPrice(for: symbol)
    }
    
    private func fetchStockHistory(for symbol: String) async {
        isLoadingHistory = true
        defer { isLoadingHistory = false }
        
        stockHistory = await stockManager.fetchStockHistory(for: symbol)
    }
}
