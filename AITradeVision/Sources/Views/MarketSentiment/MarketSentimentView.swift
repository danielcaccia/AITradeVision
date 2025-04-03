//
//  SentimentAnalysisView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI

struct SentimentAnalysisView: View {
    @StateObject private var viewModel = MarketSentimentViewModel()
    @EnvironmentObject var coordinator: AppCoordinator
    
    let stockSymbol: String
    
    var body: some View {
        VStack {
            Text("Análise de Sentimento para \(stockSymbol)")
                .font(.title)
                .padding()
            
            Text(viewModel.sentiment.text)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(viewModel.sentiment.color)
                .padding()
            
            Spacer()
            
            Button("Voltar") {
                coordinator.currentView = .marketDashboard
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
