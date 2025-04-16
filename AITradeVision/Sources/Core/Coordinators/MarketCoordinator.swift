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
    
    weak var appCoordinator: AppCoordinator!
    
    enum MarketRoute: Equatable {
        case marketDashboard
        case stockDetail(stock: StockQuoteDTO)
        case sentimentAnalysis(stockSymbol: String)
        case stockHistory(stockSymbol: String)
    }
    
    func start() -> some View {
        MarketContainerView()
            .environmentObject(self)
            .environmentObject(appCoordinator)
    }
    
    @ViewBuilder
    func buildCurrentView(for route: MarketRoute) -> some View {
        switch route {
        case .marketDashboard:
            let stockManager = StockManager(errorHandler: errorHandler)
            let marketIndexManager = MarketIndexManager(errorHandler: errorHandler)
            let alertChecker = AlertChecker(stockManager: stockManager)
            let viewModel = MarketDashboardViewModel(
                stockManager: stockManager,
                marketIndexManager: marketIndexManager,
                appCoordinator: appCoordinator
            )
            
            MarketDashboardView(alertChecker: alertChecker)
                .environmentObject(viewModel)
        
        case .stockDetail(let stock):
            let stockManager = StockManager(errorHandler: errorHandler)
            let viewModel = StockDetailsViewModel(symbol: stock.symbol, stockManager: stockManager)
            
            StockDetailsView(stock: stock)
                .environmentObject(viewModel)
            
        case .sentimentAnalysis(let symbol):
            let newsManager = NewsManager(errorHandler: errorHandler)
            let sentimentManager = SentimentManager(errorHandler: errorHandler)
            let viewModel = MarketSentimentViewModel(newsManager: newsManager, sentimentManager: sentimentManager)
            
            MarketSentimentView(stockSymbol: symbol)
                .environmentObject(viewModel)
            
        case .stockHistory(let symbol):
            let stockManager = StockManager(errorHandler: errorHandler)
            let viewModel = StockChartViewModel(stockManager: stockManager)
            
            StockChartView(stockSymbol: symbol)
                .environmentObject(viewModel)
        }
    }
}
