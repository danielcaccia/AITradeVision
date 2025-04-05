//
//  APIService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

typealias HTTPHeader = [String: String]
typealias HTTPBody = [String: Any]

protocol APIService {
    /// Creates a request with a given `Endpoint`, an `HTTPMethod` and optionals `HTTPHeader` and `HTTPBody`. Returns on a completion block, a Result with type `T`, which conforms to `Decodable` protocol.
    func request<T: Decodable>(
        endpoint: Endpoint,
        method: HTTPMethod,
        header: HTTPHeader?,
        body: HTTPBody?
    ) async throws -> T?
}

extension APIService {
    func request<T: Decodable>(
        endpoint: Endpoint,
        method: HTTPMethod,
        header: HTTPHeader? = nil,
        body: HTTPBody? = nil
    ) async throws -> T {
        guard let url = URL(string: "\(endpoint.baseURL)\(endpoint.pathParameters)") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.generateHeader(with: header)
        request.generateBody(with: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw APIError.serverError(errorResponse)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            let message = "Data corrupted: \(context)"
            throw APIError.decodingError(ErrorResponse(code: httpResponse.statusCode, message: message))
        } catch let DecodingError.keyNotFound(key, context) {
            let message = "Key '\(key)' not found: \(context.debugDescription)"
            throw APIError.decodingError(ErrorResponse(code: httpResponse.statusCode, message: message))
        } catch let DecodingError.typeMismatch(type, context) {
            let message = "Type mismatch for type \(type): \(context.debugDescription)"
            throw APIError.decodingError(ErrorResponse(code: httpResponse.statusCode, message: message))
        } catch let DecodingError.valueNotFound(type, context) {
            let message = "Value of type \(type) not found: \(context.debugDescription)"
            throw APIError.decodingError(ErrorResponse(code: httpResponse.statusCode, message: message))
        } catch {
            throw APIError.unknownError(error)
        }
    }
}
