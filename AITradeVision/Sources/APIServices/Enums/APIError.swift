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
    case serverError(ErrorResponse)
    case decodingError(ErrorResponse)
    case unknownError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid Response."
        case .serverError(let error), .decodingError(let error):
            return """
            Server error occurred.
            Status code: \(error.code).
            Message:
            \(error.message)
            """
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
