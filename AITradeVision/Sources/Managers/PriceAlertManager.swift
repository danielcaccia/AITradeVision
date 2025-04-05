//
//  PriceAlertManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import Foundation

class PriceAlertManager: ObservableObject {
    @Published private(set) var alerts: [PriceAlert] = []
    
    private let storageKey = "SAVED_PRICE_ALERTS"

    init() {
        loadAlerts()
    }

    func addAlert(_ alert: PriceAlert) {
        alerts.append(alert)
        saveAlerts()
    }

    func removeAlert(_ alert: PriceAlert) {
        alerts.removeAll { $0.id == alert.id }
        saveAlerts()
    }

    func loadAlerts() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([PriceAlert].self, from: data) {
            alerts = saved
        }
    }
    
    private func saveAlerts() {
        if let data = try? JSONEncoder().encode(alerts) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}
