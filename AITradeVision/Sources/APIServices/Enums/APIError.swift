//
//  APIError.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case serverError
    case decodingError
    case unknownError
    case customError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .serverError:
            return "Server error occurred."
        case .decodingError:
            return "Error decoding the response."
        case .unknownError:
            return "An unknown error occurred."
        case .customError(let message):
            return message
        }
    }
    
    var detailedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL you are trying to reach is not valid."
        case .serverError:
            return "The server responded with an error. Please try again later."
        case .decodingError:
            return "There was an error while trying to parse the response from the server."
        case .unknownError:
            return "An unexpected error occurred."
        case .customError(let message):
            return message
        }
    }
}
