//
//  MarketNewsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketNewsView: View {
    @ObservedObject var viewModel: MarketDashboardViewModel

    @State private var showingNewsWebView = false

    var body: some View {
        TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.sm) {
            TradeVisionLabel("Latest News", type: .sectionHeader)
            
            TradeVisionVStack {
                if viewModel.isLoadingLatestNews {
                    ProgressView("Carregando últimas notícias...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if viewModel.latestNews.isEmpty {
                    TradeVisionLabel("Oops. Parece que não temos notícias...", type: .subtitle, alignment: .center)
                } else {
                    ForEach(Array(viewModel.latestNews.enumerated()), id: \.1.id) { index, article in
                        TradeVisionVStack(alignment: .leading, spacing: TradeVisionSpacing.xs) {
                            TradeVisionLabel(article.title, type: .title)
                            if let description = article.description {
                                TradeVisionLabel(description, type: .subtitle)
                                    .lineLimit(2)
                            }
                            TradeVisionLabel("Read more", type: .title, alignment: .trailing)
                        }
                        .padding(.vertical, TradeVisionSpacing.xs)
                        .onTapGesture {
                            viewModel.selectedNews = article
                            showingNewsWebView = true
                        }
                        
                        if index < viewModel.watchlist.count - 1 {
                            TradeVisionDivider()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .tradeVisionCard()
        }
        .sheet(isPresented: $showingNewsWebView) {
            if let url = viewModel.selectedNews?.url {
                NewsWebView(url: url)
            }
        }
    }
}
