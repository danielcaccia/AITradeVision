//
//  APIService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

protocol APIService {
    /// Creates a request with a given `Endpoint`, an `HTTPMethod` and an optional `HTTPBody`. Returns on a completion block, a Result with type `T`, which conforms to `Decodable` protocol.
    func request<T: Decodable>(endpoint: Endpoint, method: HTTPMethod) async throws -> T?
}

extension APIService {
    func request<T: Decodable>(endpoint: Endpoint, method: HTTPMethod) async throws -> T {
        guard let url = URL(string: "\(endpoint.baseURL)\(endpoint.pathParameters)") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(error: decodingError)
        } catch let error as APIError {
            if case let .serverError(statusCode) = error {
                throw APIError.serverError(statusCode: statusCode)
            } else {
                throw APIError.unknownError(error: error, statusCode: nil)
            }
        } catch {
            throw APIError.unknownError(error: error, statusCode: nil)
        }
    }
}
