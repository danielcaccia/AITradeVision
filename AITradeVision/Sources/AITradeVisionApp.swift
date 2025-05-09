//
//  AITradeVisionApp.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI
import TradeVisionUI
import Firebase
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct AITradeVisionApp: App {
    @AppStorage("SELECTED_THEME") private var selectedTheme: TradeVisionColorScheme = .system
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var coordinator = AppCoordinator()
        
    init() {
        Task {
            await NotificationManager.shared.requestAuthorizationIfNeeded()
        }
        
        BackgroundTaskManager.shared.registerBackgroundTasks()
        BackgroundTaskManager.shared.scheduleAppRefresh()
        MobileAds.shared.start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.viewForCurrentFlow()
                .preferredColorScheme(selectedTheme.toColorScheme())
                .tradeVisionTheme(selectedTheme)
                .environmentObject(coordinator)
                .onAppear {
                    coordinator.checkAuthentication()
                }
        }
    }
}
