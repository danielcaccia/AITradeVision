//
//  TechnicalSignalsResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 29/04/25.
//

struct TechnicalSignalsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case technicalSignals = "technical_signals"
    }
    
    let technicalSignals: [TechnicalSignal]
}
