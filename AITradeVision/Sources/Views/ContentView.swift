//
//  ContentView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = StockViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("AITradeVision Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                List(viewModel.stockPrices) { stock in
                    HStack {
                        Text("Ação: \(stock.symbol)")
                        Spacer()
                        Text("$\(String(format: "%.2f", stock.price))")
                            .foregroundColor(stock.price >= 0 ? .green : .red)
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: SentimentAnalysisView()) {
                    Text("Análise de Sentimento")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Market Dashboard")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
