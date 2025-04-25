//
//  DividendInfoDTO.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 25/04/25.
//

import Foundation

struct DividendInfoDTO: Identifiable {
    let id: UUID
    let symbol: String
    let displayName: String
    let dividendDate: String
    let lastDividend: Double
    let yield: Double
    
    init(from dividend: DividendInfo) {
        self.id = UUID()
        self.symbol = dividend.symbol
        self.displayName = dividend.displayName
        self.dividendDate = dividend.dividendDate
        self.lastDividend = dividend.lastDividend
        self.yield = dividend.yield
    }
}
