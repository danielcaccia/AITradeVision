//
//  ErrorResponse.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 03/04/25.
//

struct ErrorResponse: Decodable {
    let code: Int
    let message: String
}
