//
//  AlertChecker.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import Foundation
import Combine

@MainActor
class AlertChecker: ObservableObject {
    @Published var isChecking: Bool = false
    @Published var lastChecked: Date?
    @Published var errorMessage: String?
    
    private let alertManager: PriceAlertManager
    private let stockManager: any StockManagerProtocol
    
    private var timerCancellable: AnyCancellable?
    
    init(
        alertManager: some PriceAlertManager = PriceAlertManager(),
        stockManager: some StockManagerProtocol = StockManager()
    ) {
        self.alertManager = alertManager
        self.stockManager = stockManager
        
        startPeriodicChecks()
    }
    
    func checkAlerts() async {
        isChecking = true
        errorMessage = nil
        
        defer {
            isChecking = false
            lastChecked = Date()
        }
        
        for alert in alertManager.alerts {
            guard let stock = await stockManager.getStockPrice(for: alert.symbol) else { return }
            let currentPrice = stock.price
            
            let shouldTrigger = alert.isGreaterThan
            ? currentPrice >= alert.targetPrice
            : currentPrice <= alert.targetPrice
            
            if shouldTrigger {
                triggerAlertNotification(for: alert, currentPrice: currentPrice)
                alertManager.removeAlert(alert)
            }
            
        }
    }
    
    func getCurrentSavedAlerts() -> [PriceAlert] {
        alertManager.loadAlerts()
        return alertManager.alerts
    }
    
    func stopPeriodicChecks() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    private func triggerAlertNotification(for alert: PriceAlert, currentPrice: Double) {
        let body = "Preço atual: \(String(format: "%.2f", currentPrice)) \(alert.isGreaterThan ? "≥" : "≤") \(String(format: "%.2f", alert.targetPrice))"
        NotificationManager.shared.scheduleNotification(
            title: "💸 Alerta: \(alert.symbol)",
            body: body
        )
    }
    
    private func startPeriodicChecks(interval: TimeInterval = 300) {
        timerCancellable = Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                Task {
                    await self?.checkAlerts()
                }
            }
    }
}
