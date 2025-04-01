//
//  Endpoint.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

enum Endpoint {
    case fetchStockPrice(symbol: String)
        
    var url: String {
        switch self {
        case .fetchStockPrice(let symbol):
            "https://query1.finance.yahoo.com/v7/finance/quote?symbols=\(symbol)"
        }
    }
}
