//
//  MarketSentimentView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI

struct MarketSentimentView: View {
    @ObservedObject private var viewModel: MarketSentimentViewModel
    
    @EnvironmentObject var coordinator: MarketCoordinator
    
    let stockSymbol: String
    
    init(viewModel: MarketSentimentViewModel, stockSymbol: String) {
        self.viewModel = viewModel
        self.stockSymbol = stockSymbol
    }
    
    var body: some View {
        VStack {
            Text("Análise de Sentimento para \(stockSymbol)")
                .font(.title)
                .padding()
            
            if viewModel.isLoading {
                ProgressView("Carregando informações...")
                        .transition(.opacity)
            } else if let sentiment = viewModel.sentiment {
                Text(sentiment.text)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(sentiment.color)
                    .padding()
            }
            
            Spacer()
            
            Button("Voltar") {
                coordinator.route = .marketDashboard
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchMarketSentiment(for: stockSymbol)
            }
        }
    }
}

//struct SentimentAnalysisView_Previews: PreviewProvider {
//    static var previews: some View {
//        SentimentAnalysisView()
//    }
//}
