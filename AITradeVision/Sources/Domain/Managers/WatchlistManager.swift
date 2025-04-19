//
//  WatchlistManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI

class WatchlistManager: ObservableObject {
    @Published var symbols: [String] = []
    
    private let key = "WATCHLIST_SYMBOLS"
    private let financeService: any FinanceServiceProtocol
    private let errorHandler: any ErrorHandler
    
    init(financeService: some FinanceServiceProtocol = FinanceService(), errorHandler: some ErrorHandler) {
        self.financeService = financeService
        self.errorHandler = errorHandler
        load()
    }
    
    private func load() {
        symbols = UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    private func save() {
        UserDefaults.standard.set(symbols, forKey: key)
    }
    
    private func validateSymbolExists(_ symbol: String) async throws -> Bool {
        return try await financeService.fetchStockPrice(for: symbol).isNotNil
    }
    
    func add(symbol: String) async {
        await Task.runWithHandling({
            let cleanSymbol = symbol.uppercased()
            
            guard !self.symbols.contains(cleanSymbol) else { throw WatchlistError.symbolAlreadyOnTheList }
            guard try await self.validateSymbolExists(cleanSymbol) else { throw WatchlistError.symbolDoesNotExist }
            
            self.symbols.append(cleanSymbol)
            self.save()
        }, errorHandler: errorHandler, context: "WatchlistManager.add")
    }
    
    func remove(symbol: String) {
        symbols.removeAll { $0.uppercased() == symbol.uppercased() }
        save()
    }
}
