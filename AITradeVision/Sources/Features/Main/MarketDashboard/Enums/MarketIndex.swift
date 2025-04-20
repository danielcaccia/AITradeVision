//
//  MarketIndex.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 13/04/25.
//

import Foundation

enum MarketIndex: String, CaseIterable {
    // 🇺🇸 US
    case DJI = "^DJI"
    case GSPC = "^GSPC"
    case IXIC = "^IXIC"
    // 🇬🇧 UK
    case FTSE = "^FTSE"
    // 🇩🇪 DE
    case GDAXI = "^GDAXI"
    // 🇫🇷 FR
    case FCHI = "^FCHI"
    // 🇯🇵 JP
    case N225 = "^N225"
    // 🇭🇰 HK
    case HSI = "^HSI"
    // 🇨🇭 CH
    case SSMI = "^SSMI"
    // 🇦🇺 AU
    case AXJO = "^AXJO"
    // 🇮🇳 IN
    case BSESN = "^BSESN"
    // 🇧🇷 BR
    case BVSP = "^BVSP"
    // 🇰🇷 KO
    case KS11 = "^KS11"
    
    var symbol: String {
        return self.rawValue
    }
    
    var friendlyDisplayName: String {
        switch self {
        case .DJI:
            "Dow 30"
        case .GSPC:
            "S&P 500"
        case .IXIC:
            "Nasdaq"
        case .FTSE:
            "FTSE 100"
        case .GDAXI:
            "DAX"
        case .FCHI:
            "CAC 40"
        case .N225:
            "Nikkei 225"
        case .HSI:
            "Hang Seng"
        case .SSMI:
            "Swiss Index"
        case .AXJO:
            "ASX 200"
        case .BSESN:
            "BSE Sensex"
        case .BVSP:
            "Ibovespa"
        case .KS11:
            "KOSPI"
        }
    }
}
