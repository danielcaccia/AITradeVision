//
//  IPOsViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import Foundation

@MainActor
class IPOsViewModel: ObservableObject {
    @Published var upcomingIPOs: [IPOInfoDTO] = []
    
    @Published var isLoadingIPOs = false
    
    private let stockManager: any StockManagerProtocol
    
    init(stockManager: some StockManagerProtocol) {
        self.stockManager = stockManager
        
        Task {
            await fetchUpcomingDividends()
        }
    }
    
    private func fetchUpcomingDividends() async {
        isLoadingIPOs = true
        defer { isLoadingIPOs = false }
        
        upcomingIPOs = await stockManager.fetchUpcomingIPOs()
    }
}
