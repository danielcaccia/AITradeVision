//
//  TechnicalSignal.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 29/04/25.
//

import Foundation

struct TechnicalSignal: Decodable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case lastPrice = "last_price"
        case rsi
        case macdCross = "macd_cross"
        case signalSummary = "signal_summary"
    }

    let symbol: String
    let name: String?
    let lastPrice: Double
    let rsi: Double?
    let macdCross: MACDCrossType
    let signalSummary: String?
}

enum MACDCrossType: String, Decodable {
    case bearish
    case bullish
}
