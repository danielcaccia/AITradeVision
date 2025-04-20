//
//  MarketMoversDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 15/04/25.
//

import Foundation

struct MarketMoversDTO {
    let gainers: [MarketMoverDTO]
    let losers: [MarketMoverDTO]
    
    init(from movers: MarketMovers) {
        self.gainers = movers.gainers.map {  MarketMoverDTO(from: $0 )}
        self.losers = movers.losers.map {  MarketMoverDTO(from: $0 )}
    }
    
    init(gainers: [MarketMover], losers: [MarketMover]) {
        self.gainers = gainers.map {  MarketMoverDTO(from: $0 )}
        self.losers = losers.map {  MarketMoverDTO(from: $0 )}
    }
}
