//
//  Untitled.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 15/04/25.
//

import Foundation

struct MarketMover: Decodable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case displayName = "name"
        case currentPrice = "price"
        case variation
        case volumeSpike = "volume_spike"
        case currentVolume = "current_volume"
        case averageVolume = "avg_volume"
    }
    
    let symbol: String
    let displayName: String
    let currentPrice: Double
    let variation: Double
    let volumeSpike: Double
    let currentVolume: Double
    let averageVolume: Double
}
