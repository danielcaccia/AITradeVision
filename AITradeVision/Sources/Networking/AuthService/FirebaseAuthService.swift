//
//  FirebaseAuthService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws
    func logout() async throws
}

final class FirebaseAuthService: AuthServiceProtocol {
    func login(email: String, password: String) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }

    func logout() async throws {
        try Auth.auth().signOut()
    }
}
