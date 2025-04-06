//
//  MockErrorHandler.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

@testable import AITradeVision

class MockErrorHandler: ErrorHandler {
    func handle(_ error: any Error, context: String?) {
        errorHandled = true
    }
    
    func presentableMessage(for error: any Error) -> String {
        return "TestErrorMessage"
    }
    
    var errorHandled = false
}
