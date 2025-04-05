//
//  DefaultErrorHandler.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import Foundation
import os

final class DefaultErrorHandler: ErrorHandler {
    private let logger = Logger(subsystem: "com.danielcaccia.AITradeVision", category: "ErrorHandler")

    func handle(_ error: Error, context: String? = nil) {
        let message = "[Erro] \(context ?? "sem contexto"): \(error.localizedDescription)"
        logger.error("\(message, privacy: .public)")

        // Analytics (exemplo)
        // Analytics.logEvent("error_occurred", parameters: [
        //     "context": context ?? "unknown",
        //     "error": error.localizedDescription
        // ])

        if let userMessage = userFriendlyMessage(error) {
            showToast(userMessage)
        }
    }

    func presentableMessage(for error: Error) -> String {
        userFriendlyMessage(error) ?? "Something went wrong. Try again."
    }

    private func userFriendlyMessage(_ error: Error) -> String? {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "No connection to the internet."
            case .timedOut:
                return "Request timeout."
            default:
                return "Network error: \(urlError.localizedDescription)"
            }
        }

        if let apiError = error as? APIError {
            return apiError.friendlyDescription
        }

        return nil
    }

    private func showToast(_ message: String) {
        print("📣 TOAST: \(message)")
    }
}
