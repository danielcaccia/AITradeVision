//
//  Double+Extension.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 13/04/25.
//

import Foundation
import TradeVisionUI

extension Double {
    var labelType: TradeVisionLabelType {
        if self > 0 {
            return .success
        } else if self < 0 {
            return .error
        } else {
            return .title
        }
    }
    
    func toString(decimals: Int) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}
