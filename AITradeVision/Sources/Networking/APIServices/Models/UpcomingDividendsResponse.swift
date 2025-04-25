//
//  UpcomingDividendsResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 25/04/25.
//

struct UpcomingDividendsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case upcomingDividends = "upcoming_dividends"
    }
    
    let upcomingDividends: [DividendInfo]
}
