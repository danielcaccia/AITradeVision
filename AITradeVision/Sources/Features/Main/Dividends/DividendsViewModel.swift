//
//  DividendsViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import Foundation

@MainActor
class DividendsViewModel: ObservableObject {
    @Published var upcomingDividends: [DividendInfoDTO] = []
    
    @Published var isLoadingDividends = false
    
    private let stockManager: any StockManagerProtocol
    
    init(stockManager: some StockManagerProtocol) {
        self.stockManager = stockManager
        
        Task {
            await fetchUpcomingDividends()
        }
    }
    
    private func fetchUpcomingDividends() async {
        isLoadingDividends = true
        defer { isLoadingDividends = false }
        
        upcomingDividends = await stockManager.fetchUpcomingDividends()
    }
}
