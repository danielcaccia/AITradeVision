//
//  DividendInfo.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 25/04/25.
//

import Foundation

struct DividendInfo: Codable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case displayName = "name"
        case dividendDate = "dividend_date"
        case lastDividend = "last_dividend"
        case yield
    }
    
    let symbol: String
    let displayName: String
    let dividendDate: String
    let lastDividend: Double
    let yield: Double
}
