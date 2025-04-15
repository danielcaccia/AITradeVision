//
//  MarketMovers.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 15/04/25.
//

struct MarketMovers: Decodable {
    let gainers: [MarketMover]
    let losers: [MarketMover]
}
