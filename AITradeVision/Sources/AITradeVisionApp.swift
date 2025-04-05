//
//  AITradeVisionApp.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI

@main
struct AITradeVisionApp: App {
    @StateObject var coordinator = AppCoordinator()
    
    init() {
        Task {
            await NotificationManager.shared.requestAuthorizationIfNeeded()
        }
        
        BackgroundTaskManager.shared.registerBackgroundTasks()
        BackgroundTaskManager.shared.scheduleAppRefresh()
    }
    
    var body: some Scene {
        WindowGroup {
            switch coordinator.currentView {
            case .marketDashboard:
                MarketDashboardView().environmentObject(coordinator)
            case .sentimentAnalysis(let symbol):
                SentimentAnalysisView(stockSymbol: symbol).environmentObject(coordinator)
            case .stockHistory(stockSymbol: let symbol):
                StockChartView(stockSymbol: symbol).environmentObject(coordinator)
            }
        }
    }
}
