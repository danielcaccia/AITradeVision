//
//  AppCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var currentView: AppView = .marketDashboard
    
    private let errorHandler = DefaultErrorHandler()
    
    enum AppView {
        case marketDashboard
        case sentimentAnalysis(stockSymbol: String)
        case stockHistory(stockSymbol: String)
    }
    
    func navigate(to view: AppView) {
        currentView = view
    }
}

extension AppCoordinator {
    @MainActor @ViewBuilder
    func buildCurrentView() -> some View {
        switch currentView {
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
