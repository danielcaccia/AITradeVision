//
//  RadarViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import Foundation

@MainActor
class RadarViewModel: ObservableObject {
    @Published var signals: [TechnicalSignalDTO] = []
    
    @Published var isLoadingSignals = false
    
    private let stockManager: any StockManagerProtocol
    
    init(stockManager: some StockManagerProtocol) {
        self.stockManager = stockManager
        
        Task {
            await fetchUpcomingDividends()
        }
    }
    
    private func fetchUpcomingDividends() async {
        isLoadingSignals = true
        defer { isLoadingSignals = false }
        
        signals = await stockManager.fetchTechnicalSignals()
    }
}
