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
    
    var body: some Scene {
        WindowGroup {
            switch coordinator.currentView {
            case .marketDashboard:
                MarketDashboardView()
                    .environmentObject(coordinator)
            case .sentimentAnalysis:
                SentimentAnalysisView()
                    .environmentObject(coordinator)
            }
        }
    }
}
