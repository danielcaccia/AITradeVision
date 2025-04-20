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
    
    private let networkingHandler = NetworkingErrorHandler()
    private let watchlistHandler = WatchlistErrorHandler()
    
    weak var appCoordinator: AppCoordinator!
    
    enum MarketRoute: Equatable {
        case marketDashboard
        case stockDetail(stockSymbol: String)
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
            let watchlistManager = WatchlistManager(errorHandler: watchlistHandler)
            let stockManager = StockManager(errorHandler: networkingHandler)
            let marketIndexManager = MarketIndexManager(errorHandler: networkingHandler)
            let newsManager = NewsManager(errorHandler: networkingHandler)
            let alertChecker = AlertChecker(stockManager: stockManager)
            
            let viewModel = MarketDashboardViewModel(
                watchlistManager: watchlistManager,
                stockManager: stockManager,
                marketIndexManager: marketIndexManager,
                newsManager: newsManager,
                appCoordinator: appCoordinator
            )
            
            MarketDashboardView(alertChecker: alertChecker)
                .environmentObject(viewModel)
        
        case .stockDetail(let stockSymbol):
            let stockManager = StockManager(errorHandler: networkingHandler)
            let viewModel = StockDetailsViewModel(symbol: stockSymbol, stockManager: stockManager)
            
            StockDetailsView()
                .environmentObject(viewModel)
        }
    }
}
