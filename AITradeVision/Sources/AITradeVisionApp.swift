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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var coordinator = AppCoordinator()
    
    @State private var scheme: TradeVisionColorScheme = .system
    
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
                .tradeVisionTheme(scheme)
                .environmentObject(coordinator)
                .onAppear {
                    coordinator.checkAuthentication()
                }
        }
    }
}
