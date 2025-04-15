//
//  MarketMoversResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 15/04/25.
//

struct MarketMoversResponse: Decodable {
    let gainers: [MarketMover]
    let losers: [MarketMover]
}
