//
//  StockChartView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 04/04/25.
//

import SwiftUI
import Charts

struct StockChartView: View {
    @ObservedObject private var viewModel: StockChartViewModel
    
    @EnvironmentObject var coordinator: MarketCoordinator
    
    let stockSymbol: String
    
    init(viewModel: StockChartViewModel, stockSymbol: String) {
        self.viewModel = viewModel
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
            } else {
                Chart(viewModel.stockHistory) { stock in
                    LineMark(
                        x: .value("Data", stock.date),
                        y: .value("Preço", stock.price)
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
