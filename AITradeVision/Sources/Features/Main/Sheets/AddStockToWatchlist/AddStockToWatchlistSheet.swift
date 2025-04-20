//
//  AddStockToWatchlistSheet.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 16/04/25.
//

import SwiftUI
import TradeVisionUI

struct AddStockToWatchlistSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: MarketDashboardViewModel
        
    @State private var newSymbol: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Stock Symbol (ex: AAPL)", text: $newSymbol)
                
                TradeVisionButton(type: .primary("Add to Watchlist")) {
                    viewModel.tryAddSymbol(newSymbol)
                    dismiss()
                }
                .disabled(newSymbol.isEmpty)
            }
            .tradeNavigationBar(title: "Add to Watchlist")
            .withCancelButton()
        }
    }
}
