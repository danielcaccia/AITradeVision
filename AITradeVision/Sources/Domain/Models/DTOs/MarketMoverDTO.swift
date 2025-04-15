//
//  MarketMoverDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 15/04/25.
//

import Foundation

struct MarketMoverDTO: Identifiable, Equatable {
    let id: UUID
    let symbol: String
    let displayName: String
    let currentPrice: Double
    let variation: Double
    let volumeSpike: Double
    let currentVolume: Double
    let averageVolume: Double
    
    init(from mover: MarketMover) {
        self.id = UUID()
        self.symbol = mover.symbol
        self.displayName = mover.displayName
        self.currentPrice = mover.currentPrice
        self.variation = mover.variation
        self.volumeSpike = mover.volumeSpike
        self.currentVolume = mover.currentVolume
        self.averageVolume = mover.averageVolume
    }
}
