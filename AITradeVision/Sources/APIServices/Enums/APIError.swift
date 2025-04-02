//
//  APIError.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError(error: DecodingError)
    case unknownError(error: Error, statusCode: Int?)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid Response."
        case .serverError(let statusCode):
            return "Server error occurred. Status code: \(statusCode)."
        case .decodingError(let error):
            return "Error decoding the response: \(error.localizedDescription)"
        case .unknownError(let error, let statusCode):
            let statusCodeMessage = statusCode.isNotNil ? " Status code: \(statusCode!)." : ""
            return "An unknown error occurred: \(error.localizedDescription)" + statusCodeMessage
        }
    }
}
