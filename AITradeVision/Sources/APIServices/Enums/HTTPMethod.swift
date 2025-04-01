//
//  HTTPMethod.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    
    var string: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        }
    }
}
