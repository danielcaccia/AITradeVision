//
//  DividendInfo.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 25/04/25.
//

import Foundation

struct DividendInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case displayName = "name"
        case dividendDate = "ex_dividend_date"
        case dividendPerShare = "dividend_per_share"
    }
    
    let symbol: String
    let displayName: String
    let dividendDate: String
    let dividendPerShare: Double
}
