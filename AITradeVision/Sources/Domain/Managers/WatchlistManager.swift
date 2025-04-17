//
//  WatchlistManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI

class WatchlistManager: ObservableObject {
    @EnvironmentObject var stockManager: StockManager
    
    @Published var symbols: [String] = []
    
    private let key = "WATCHLIST_SYMBOLS"
    
    init() {
        load()
    }
    
    private func load() {
        symbols = UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    private func save() {
        UserDefaults.standard.set(symbols, forKey: key)
    }
    
    func add(symbol: String) {
        let cleanSymbol = symbol.uppercased()
        
        guard !symbols.contains(cleanSymbol) else { return }
        
        symbols.append(cleanSymbol)
        save()
    }
    
    func tryAddSymbol(_ symbol: String) {
        let cleanSymbol = symbol.uppercased()
        
        guard !symbols.contains(cleanSymbol) else {
//            showErrorMessage = "Esse ativo já está na sua watchlist."
            return
        }

        Task { @MainActor in
            guard await validateSymbolExists(cleanSymbol) else {
//                self.showErrorMessage = "Símbolo inválido: \(cleanSymbol)"
                return
            }
            
            save()
        }
    }
    
    func validateSymbolExists(_ symbol: String) async -> Bool {
        return await stockManager.getStockPrice(for: symbol).isNotNil
    }
    
    func remove(symbol: String) {
        symbols.removeAll { $0.uppercased() == symbol.uppercased() }
        save()
    }
}
