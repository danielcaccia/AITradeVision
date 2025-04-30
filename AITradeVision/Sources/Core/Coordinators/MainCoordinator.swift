//
//  MainCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

@MainActor
final class MainCoordinator: Coordinator, ObservableObject {
    @Published var route: MarketRoute = .marketDashboard
    
    private let networkingHandler = NetworkingErrorHandler()
    private let watchlistHandler = WatchlistErrorHandler()
    
    weak var appCoordinator: AppCoordinator!
    
    enum MarketRoute: Equatable {
        case marketDashboard
        case stockDetail(stockSymbol: String)
        case nextDividends
        case nextIPOs
        case technicalRadar
        case aiPicks
    }
    
    func start() -> some View {
        MainContainerView()
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
            
        case .nextDividends:
            let stockManager = StockManager(errorHandler: networkingHandler)
            let viewModel = DividendsViewModel(stockManager: stockManager)
            
            DividendsView()
                .environmentObject(viewModel)
            
        case .nextIPOs:
            let stockManager = StockManager(errorHandler: networkingHandler)
            let viewModel = IPOsViewModel(stockManager: stockManager)
            
            IPOsView()
                .environmentObject(viewModel)
            
        case .technicalRadar:
            let stockManager = StockManager(errorHandler: networkingHandler)
            let viewModel = RadarViewModel(stockManager: stockManager)
            
            RadarView()
                .environmentObject(viewModel)
            
        case .aiPicks:
            let viewModel = AIPicksViewModel()
            
            AIPicksView()
                .environmentObject(viewModel)
        }
    }
}
