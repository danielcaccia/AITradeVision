//
//  MarketMoversView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketMoversView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    @ObservedObject var viewModel: MarketDashboardViewModel
    
    @State private var selectedSection: MarketMoversSection = .trending
    @State private var scrollTarget = UUID()
    
    var body: some View {
        TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
            TradeVisionVStack(alignment: .leading) {
                TradeVisionLabel("Market Movers", type: .sectionHeader)
                TradeVisionPicker(selection: $selectedSection) {
                    ForEach(MarketMoversSection.allCases) { section in
                        TradeVisionLabel(section.title, type: .subtitle, alignment: .center).tag(section)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    TradeVisionHStack {
                        Color.clear.frame(width: 0).id(scrollTarget)
                        
                        if viewModel.isLoadingMovers {
                            marketMoverCard(mover: nil)
                            marketMoverCard(mover: nil)
                            marketMoverCard(mover: nil)
                        } else {
                            switch selectedSection {
                            case .trending:
                                if viewModel.marketTrending.isEmpty {
                                    TradeVisionLabel("Market Trending está vazia.", type: .subtitle, alignment: .center)
                                        .padding()
                                } else {
                                    ForEach(viewModel.marketTrending) { mover in
                                        marketMoverCard(mover: mover)
                                            .onTapGesture {
                                                coordinator.route = .stockDetail(stockSymbol: mover.symbol)
                                            }
                                    }
                                }
                            case .gainers:
                                if viewModel.marketMovers.gainers.isEmpty {
                                    TradeVisionLabel("Top Gainers está vazia.", type: .subtitle, alignment: .center)
                                        .padding()
                                } else {
                                    ForEach(viewModel.marketMovers.gainers) { mover in
                                        marketMoverCard(mover: mover)
                                            .onTapGesture {
                                                coordinator.route = .stockDetail(stockSymbol: mover.symbol)
                                            }
                                    }
                                }
                            case .losers:
                                if viewModel.marketMovers.losers.isEmpty {
                                    TradeVisionLabel("Top Losers está vazia.", type: .subtitle, alignment: .center)
                                        .padding()
                                } else {
                                    ForEach(viewModel.marketMovers.losers) { mover in
                                        marketMoverCard(mover: mover)
                                            .onTapGesture {
                                                coordinator.route = .stockDetail(stockSymbol: mover.symbol)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.leading, -TradeVisionSpacing.md)
                    .padding(.vertical, TradeVisionSpacing.xs)
                }
                .onChange(of: selectedSection) { _ in
                    scrollTarget = UUID()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        proxy.scrollTo(scrollTarget, anchor: .leading)
                    }
                }
            }
            .animation(.easeInOut(duration: 0.3), value: selectedSection)
        }
    }
    
    private func marketMoverCard(mover: MarketMoverDTO?) -> some View {
        TradeVisionHStack {
            TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.xs) {
                TradeVisionLabel(mover?.symbol ?? "Placeholder", type: .title)
                TradeVisionLabel(mover?.displayName ?? "Placeholder", type: .subtitle)
                    .lineLimit(1, reservesSpace: true)
                    .minimumScaleFactor(0.8)
                    .truncationMode(.tail)
            }
            .layoutPriority(1)
            
            TradeVisionLabel("\(mover?.variation.toString(decimals: 2) ?? "0.00")%", type: mover?.variation.labelType ?? .success, alignment: .trailing)
                .fixedSize()
        }
        .frame(width: 220)
        .transition(.opacity.combined(with: .slide))
        .tradeVisionCard()
        .shimmering(isActive: viewModel.isLoadingMovers)
    }
}
