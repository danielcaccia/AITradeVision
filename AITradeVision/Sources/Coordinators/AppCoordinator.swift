//
//  AppCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var currentView: AppView = .marketDashboard
    
    enum AppView {
        case marketDashboard
        case sentimentAnalysis(stockSymbol: String)
    }
    
    func navigate(to view: AppView) {
        currentView = view
    }
}
