//
//  MarketTrendingResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 15/04/25.
//

struct MarketTrendingResponse: Decodable {
    let trending: [MarketMover]
}
