//
//  Stock.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

struct Stock: Codable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case marketPrice = "regularMarketPrice"
    }
    
    let symbol: String
    let marketPrice: Double
}
