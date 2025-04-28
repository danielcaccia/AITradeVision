//
//  IPOInfo.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 28/04/25.
//

import Foundation

struct IPOInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case displayName = "name"
        case exchange = "exchange"
        case ipoDate = "ipo_date"
        case priceRange = "price_range"
    }
    
    let symbol: String
    let displayName: String
    let exchange: String
    let ipoDate: String
    let priceRange: Double
}
