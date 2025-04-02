//
//  Optional+Extension.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

extension Optional {
    /// A Boolean value indicating whether the optional is Nil.
    var isNil: Bool { self == nil }
    
    /// A Boolean value indicating whether the optional is not Nil.
    var isNotNil: Bool { self != nil }
}
