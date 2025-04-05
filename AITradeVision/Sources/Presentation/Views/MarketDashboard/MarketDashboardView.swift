//
//  MarketDashboardView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI

struct MarketDashboardView: View {
    @ObservedObject private var viewModel: MarketDashboardViewModel
    @ObservedObject private var alertChecker: AlertChecker
    
    @State private var showAddAlert = false
    
    @EnvironmentObject var coordinator: AppCoordinator
    
    init(viewModel: MarketDashboardViewModel, alertChecker: AlertChecker) {
        self.viewModel = viewModel
        self.alertChecker = alertChecker
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 16) {
                    if alertChecker.isChecking {
                        ProgressView("Verificando alertas...")
                    } else if let last = alertChecker.lastChecked {
                        Text("Última verificação: \(last.formatted(date: .abbreviated, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        List(alertChecker.getCurrentSavedAlerts()) { alert in
                            Text("Açåo: \(alert.symbol) - Preço alvo: \(alert.targetPrice)")
                                .padding()
                        }
                    }
                    
                    if let error = alertChecker.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    
                    Button("Verificar Agora") {
                        Task {
                            await alertChecker.checkAlerts()
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button("➕ Adicionar Alerta") {
                        showAddAlert = true
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .navigationTitle("AI Trade Vision")
                .sheet(isPresented: $showAddAlert) {
                    AddPriceAlertView()
                }
                
                Text("AITradeVision Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView("Carregando informações...")
                        .transition(.opacity)
                } else {
                    List(viewModel.stockPrices) { stock in
                        HStack {
                            Text("Ação: \(stock.symbol)")
                            Spacer()
                            Text("$\(String(format: "%.2f", stock.price))")
                                .foregroundColor(stock.price >= 0 ? .green : .red)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    coordinator.navigate(to: .sentimentAnalysis(stockSymbol: viewModel.randomSymbol() ))
                }) {
                    Text("Análise de Sentimento")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {
                    coordinator.navigate(to: .stockHistory(stockSymbol: viewModel.randomSymbol() ))
                }) {
                    Text("Histórico de Preços")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Market Dashboard")
            .onAppear {
                Task {
                    await alertChecker.checkAlerts()
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
