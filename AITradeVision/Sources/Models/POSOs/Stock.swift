//
//  Stock.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

struct Stock: Codable {
    enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case price = "05. price"
    }
    
    let symbol: String
    let price: String
}
