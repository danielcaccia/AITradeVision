//
//  StockChartView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 04/04/25.
//

import SwiftUI
import Charts

struct StockChartView: View {
    @EnvironmentObject private var viewModel: StockChartViewModel
    @EnvironmentObject var coordinator: MarketCoordinator
    
    let stockSymbol: String
    
    init(stockSymbol: String) {
        self.stockSymbol = stockSymbol
    }
    
    var body: some View {
        VStack {
            Text("Histórico de Preços: \(stockSymbol)")
                .font(.title2)
                .padding()

            if viewModel.isLoading {
                ProgressView("Carregando informações...")
                        .transition(.opacity)
            } else if let history = viewModel.stockHistory?.historicQuotes {
                Chart(history) { quote in
                    LineMark(
                        x: .value("Data", quote.date),
                        y: .value("Preço", quote.closePrice)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.blue)
                    .symbol(Circle())
                }
                .frame(height: 300)
                .padding()
                .animation(.easeInOut, value: viewModel.stockHistory)
            }

            Spacer()
            
            Button("Voltar") {
                coordinator.route = .marketDashboard
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchStockHistory(for: stockSymbol)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
