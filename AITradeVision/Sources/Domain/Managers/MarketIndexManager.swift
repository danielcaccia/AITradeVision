//
//  MarketIndexManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 13/04/25.
//

import Foundation

protocol MarketIndexManagerProtocol {
    func fetchMarketIndexQuote(for symbol: String) async -> MarketIndexQuoteDTO?
}

class MarketIndexManager: MarketIndexManagerProtocol {
    private let financeService: any FinanceServiceProtocol
    private let errorHandler: any ErrorHandler
    
    init(financeService: some FinanceServiceProtocol = FinanceService(), errorHandler: some ErrorHandler) {
        self.financeService = financeService
        self.errorHandler = errorHandler
    }
    
    func fetchMarketIndexQuote(for symbol: String) async -> MarketIndexQuoteDTO? {
        await Task.runWithHandling({
            guard let indexQuote = try await self.financeService.fetchMarketIndexQuote(for: symbol) else { return nil }
                return MarketIndexQuoteDTO(from: indexQuote)
            }, errorHandler: errorHandler, context: "MarketIndexManager.fetchMarketIndexQuote")
    }
}
