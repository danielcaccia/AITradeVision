//
//  URLRequest+Extension.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 02/04/25.
//

import Foundation

extension URLRequest {
    /// Adds key/value pair headers to the receiver.
    mutating func generateHeader(with header: HTTPHeader?) {
        guard let header else { return }
        for (key, value) in header {
            self.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    /// Adds a body  to the receiver.
    mutating func generateBody(with body: HTTPBody?) {
        guard let body else { return }
        self.httpBody = try? JSONSerialization.data(withJSONObject: body)
    }
}
