//
//  UpcomingIPOsResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 28/04/25.
//

struct UpcomingIPOsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case upcomingIPOs = "upcoming_ipos"
    }
    
    let upcomingIPOs: [IPOInfo]
}
