//
//  AddStockSheet.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI

struct AddStockSheet: View {
    @Binding var watchlist: [StockQuoteDTO]
    
    @Environment(\.dismiss) var dismiss
    
    @State private var newSymbol: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Stock Symbol (ex: AAPL)", text: $newSymbol)
                
                Button("Add to Watchlist") {
                    let symbol = newSymbol.uppercased()
                    // Simulação: você pode depois chamar o backend aqui
                    watchlist.append(StockQuoteDTO(from: StockQuote(symbol: "AAPL", displayName: "Apple5", open: 1, dayHigh: 5, dayLow: 0.8, latestPrice: 4, latestVolume: 100, variation: 2.0)))
                    dismiss()
                }
                .disabled(newSymbol.isEmpty)
            }
            .tradeNavigationBar(title: "Add to Watchlist")
            .withCancelButton()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
