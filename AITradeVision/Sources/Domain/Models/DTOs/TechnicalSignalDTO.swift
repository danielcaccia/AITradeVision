//
//  TechnicalSignalDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 29/04/25.
//

import Foundation

struct TechnicalSignalDTO: Identifiable {
    let id: UUID
    let symbol: String
    let name: String?
    let lastPrice: Double
    let rsi: Double?
    let macdCross: String?
    let signalSummary: MACDCrossTypeDTO
    
    init(from signal: TechnicalSignal) {
        self.id = UUID()
        self.symbol = signal.symbol
        self.name = signal.name
        self.lastPrice = signal.lastPrice
        self.rsi = signal.rsi
        self.macdCross = signal.macdCross
        self.signalSummary = MACDCrossTypeDTO(from: signal.signalSummary)
    }
}

enum MACDCrossTypeDTO: String, Decodable {
    case bearish
    case bullish
    
    var text: String {
        switch self {
        case .bearish:
            "Bearish Trend"
        case .bullish:
            "Bullish Trend"
        }
    }
    
    init(from macdType: MACDCrossType) {
        switch macdType {
        case .bearish:
            self = .bearish
        case .bullish:
            self = .bullish
        }
    }
}
