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
            coordinator.buildCurrentView()
                .environmentObject(coordinator)
        }
    }
}
