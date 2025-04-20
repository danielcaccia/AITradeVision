//
//  ErrorPresenter.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import SwiftUI

@MainActor
final class ErrorPresenter: ObservableObject {
    @Published var errorMessage: String?
    
    func show(_ message: String) {
        errorMessage = message
    }
}
