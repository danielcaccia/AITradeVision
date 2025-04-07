//
//  AdManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation

class AdManager: ObservableObject {
    static let shared = AdManager()

    @Published var adsRemoved: Bool = false

    private init() {
        adsRemoved = UserDefaults.standard.bool(forKey: "adsRemoved")
    }

    func removeAds() {
        adsRemoved = true
        UserDefaults.standard.set(true, forKey: "adsRemoved")
    }
}
