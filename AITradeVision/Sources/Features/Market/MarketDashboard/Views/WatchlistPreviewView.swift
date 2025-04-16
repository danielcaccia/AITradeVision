//
//  WatchlistPreviewView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct WatchlistPreviewView: View {
    @EnvironmentObject var coordinator: MarketCoordinator
    
    @ObservedObject var viewModel: MarketDashboardViewModel
    
    @State private var watchlist: [StockQuoteDTO] = [
        StockQuoteDTO(from: StockQuote(symbol: "AAPL", displayName: "Apple1", open: 1, dayHigh: 5, dayLow: 0.8, latestPrice: 4, latestVolume: 100, variation: 2.0)),
        StockQuoteDTO(from: StockQuote(symbol: "AAPL", displayName: "Apple2", open: 1, dayHigh: 5, dayLow: 0.8, latestPrice: 4, latestVolume: 100, variation: 2.0)),
        StockQuoteDTO(from: StockQuote(symbol: "AAPL", displayName: "Apple3", open: 1, dayHigh: 5, dayLow: 0.8, latestPrice: 4, latestVolume: 100, variation: 2.0)),
        StockQuoteDTO(from: StockQuote(symbol: "AAPL", displayName: "Apple4", open: 1, dayHigh: 5, dayLow: 0.8, latestPrice: 4, latestVolume: 100, variation: 2.0))
        ]
    
    @State private var showingAddSheet = false
    @State private var navigationSelection: String?
    
    var body: some View {
        TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
            TradeVisionHStack(alignment: .bottom) {
                TradeVisionLabel("Watchlist", type: .sectionHeader)
                Spacer()
                TradeVisionButton(type: .secondary("Add")) {
                    showingAddSheet = true
                }
            }
            
            TradeVisionVStack(spacing: TradeVisionSpacing.md) {
                ForEach(Array(watchlist.enumerated()), id: \.1.id) { index, quote in
                    TradeVisionHStack {
                        TradeVisionLabel(quote.symbol, type: .title)
                        Spacer()
                            .frame(maxWidth: .infinity)
                        TradeVisionLabel(quote.latestPrice.toString(decimals: 2), type: .title, alignment: .trailing)
                        TradeVisionLabel("\(quote.variation.toString(decimals: 2))%", type: quote.variation.labelType, alignment: .trailing)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.route = .stockDetail(stock: quote)
                    }
                    
                    if index < watchlist.count - 1 {
                        TradeVisionDivider()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .tradeVisionCard()
        }
        .padding(.vertical, TradeVisionSpacing.xs)
        .sheet(isPresented: $showingAddSheet) {
            AddStockSheet(watchlist: $watchlist)
        }
    }
}
