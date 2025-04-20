//
//  StockQuote.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

struct StockQuote: Decodable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case displayName = "display_name"
        case open
        case dayHigh = "day_high"
        case dayLow = "day_low"
        case latestPrice = "latest_price"
        case latestVolume = "latest_volume"
        case variation = "variation"
    }
    
    let symbol: String
    let displayName: String?
    let open: Double
    let dayHigh: Double
    let dayLow: Double
    let latestPrice: Double
    let latestVolume: Double
    let variation: Double
}
