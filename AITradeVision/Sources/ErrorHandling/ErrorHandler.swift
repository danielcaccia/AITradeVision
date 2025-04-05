//
//  ErrorHandler.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

protocol ErrorHandler {
    func handle(_ error: Error, context: String?)
    func presentableMessage(for error: Error) -> String
}
