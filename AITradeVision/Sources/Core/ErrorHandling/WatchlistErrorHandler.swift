//
//  WatchlistErrorHandler.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 19/04/25.
//

import Foundation
import os

final class WatchlistErrorHandler: ErrorHandler {
    private let logger = Logger(subsystem: "com.danielcaccia.AITradeVision", category: "ErrorHandler")

    func handle(_ error: Error, context: String? = nil) {
        let message = "[Error] \(context ?? "sem contexto"): \(error.localizedDescription)"
        logger.error("\(message, privacy: .public)")

        if let userMessage = userFriendlyMessage(error) {
            showToast(userMessage)
        }
    }

    func presentableMessage(for error: Error) -> String {
        userFriendlyMessage(error) ?? "Something went wrong. Try again."
    }

    private func userFriendlyMessage(_ error: Error) -> String? {
        if let watchlistError = error as? WatchlistError {
            return watchlistError.friendlyDescription
        }

        return nil
    }

    private func showToast(_ message: String) {
        print("📣 TOAST: \(message)")
    }
}
