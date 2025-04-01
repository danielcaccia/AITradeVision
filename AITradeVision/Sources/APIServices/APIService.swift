//
//  APIService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 01/04/25.
//

import Foundation

typealias PathParameters = [String: Any]

protocol APIService {
    /// Creates a request with a given `Endpoint`, an `HTTPMethod` and an optional `HTTPBody`. Returns on a completion block, a Result with type `T`, which conforms to `Decodable` protocol.
    func request<T: Decodable>(endpoint: Endpoint, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void)
}

extension APIService {
    func request<T: Decodable>(endpoint: Endpoint, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(endpoint.url)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.serverError))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }
}
