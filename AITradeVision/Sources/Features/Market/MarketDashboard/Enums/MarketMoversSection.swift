//
//  MarketMoversSection.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 11/04/25.
//

import Foundation

enum MarketMoversSection: String, CaseIterable, Identifiable {
    case gainers = "Top Gainers"
    case losers = "Top Losers"
    
    var id: String { self.rawValue }
}
