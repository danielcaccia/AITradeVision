//
//  MarketCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

@MainActor
final class MarketCoordinator: Coordinator, ObservableObject {
    @Published var route: MarketRoute = .marketDashboard
    
    private let errorHandler = DefaultErrorHandler()
    
    enum MarketRoute: Equatable {
        case marketDashboard
        case sentimentAnalysis(stockSymbol: String)
        case stockHistory(stockSymbol: String)
    }
    
    func start() -> some View {
        MarketContainerView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func buildCurrentView(for route: MarketRoute) -> some View {
        switch route {
        case .marketDashboard:
            let stockManager = StockManager(errorHandler: errorHandler)
            let alertChecker = AlertChecker(stockManager: stockManager)
            let viewModel = MarketDashboardViewModel(stockManager: stockManager)
            MarketDashboardView(viewModel: viewModel, alertChecker: alertChecker)
            
        case .sentimentAnalysis(let symbol):
            let newsManager = NewsManager(errorHandler: errorHandler)
            let sentimentManager = SentimentManager(errorHandler: errorHandler)
            let viewModel = MarketSentimentViewModel(newsManager: newsManager, sentimentManager: sentimentManager)
            MarketSentimentView(viewModel: viewModel, stockSymbol: symbol)
            
        case .stockHistory(let symbol):
            let stockManager = StockManager(errorHandler: errorHandler)
            let viewModel = StockChartViewModel(stockManager: stockManager)
            StockChartView(viewModel: viewModel, stockSymbol: symbol)
        }
    }
}
