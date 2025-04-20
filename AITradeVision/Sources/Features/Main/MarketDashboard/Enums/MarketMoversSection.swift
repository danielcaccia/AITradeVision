//
//  MarketMoversSection.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 11/04/25.
//

import Foundation

enum MarketMoversSection: String, CaseIterable, Identifiable {
    case trending = "TRENDING_NOW"
    case gainers = "TOP_GAINERS"
    case losers = "TOP_LOSERS"
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .trending:
            "Trending Now"
        case .gainers:
            "Top Gainers"
        case .losers:
            "Top Losers"
        }
    }
}
