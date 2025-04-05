//
//  Task+Extension.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

extension Task where Success == Never, Failure == Never {
    static func runWithHandling<T>(
        _ operation: @escaping () async throws -> T?,
        errorHandler: ErrorHandler,
        context: String? = nil
    ) async -> T? {
        do {
            let result = try await operation()
            return result
        } catch {
            errorHandler.handle(error, context: context)
            return nil
        }
    }
    
    static func runWithHandlingArray<T>(
        _ operation: @escaping () async throws -> [T]?,
        errorHandler: ErrorHandler,
        context: String? = nil
    ) async -> [T] {
        do {
            return try await operation() ?? []
        } catch {
            errorHandler.handle(error, context: context)
            return []
        }
    }
}
