//
//  WatchlistPreviewView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct WatchlistView: View {
    @EnvironmentObject var coordinator: MarketCoordinator
    
    @ObservedObject var viewModel: MarketDashboardViewModel
    
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
            
            TradeVisionVStack(spacing: TradeVisionSpacing.zero) {
                if viewModel.isLoadingWatchlist {
                    ProgressView("Carregando favoritos...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if viewModel.watchlist.isEmpty {
                    TradeVisionLabel("Sua watchlist está vazia.", type: .subtitle, alignment: .center)
                        .padding()
                } else {
                    ForEach(Array(viewModel.watchlist.enumerated()), id: \.1.id) { index, quote in
                        TradeVisionSwipeableRow {
                            viewModel.removeSymbol(quote.symbol)
                        } onTap: {
                            coordinator.route = .stockDetail(stockSymbol: quote.symbol)
                        } content: {
                            TradeVisionHStack(spacing: TradeVisionSpacing.md) {
                                TradeVisionVStack(spacing: TradeVisionSpacing.xs) {
                                    TradeVisionLabel(quote.symbol, type: .title)
                                    TradeVisionLabel(quote.displayName, type: .subtitle)
                                        .lineLimit(1, reservesSpace: true)
                                        .minimumScaleFactor(0.8)
                                        .truncationMode(.tail)
                                }
                                .layoutPriority(1)
                                .frame(maxWidth: .infinity)
                                
                                Spacer()
                                
                                TradeVisionVStack(spacing: TradeVisionSpacing.xs) {
                                    TradeVisionLabel("$\(quote.latestPrice.toString(decimals: 2))", type: .title, alignment: .trailing)
                                    TradeVisionLabel("\(quote.variation.toString(decimals: 2))%", type: quote.variation.labelType, alignment: .trailing)
                                }
                                .fixedSize()
                            }
                        }
                        
                        if index < viewModel.watchlist.count - 1 {
                            TradeVisionDivider()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .tradeVisionCard(padding: TradeVisionSpacing.zero)
        }
        .padding(.vertical, TradeVisionSpacing.xs)
        .sheet(isPresented: $showingAddSheet) {
            AddStockToWatchlistSheet(viewModel: viewModel)
        }
    }
}
