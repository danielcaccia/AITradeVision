//
//  UIErrorHandler.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

final class UIErrorHandler: @preconcurrency ErrorHandler {
    private let presenter: ErrorPresenter

    init(presenter: ErrorPresenter) {
        self.presenter = presenter
    }

    @MainActor
    func handle(_ error: Error, context: String?) {
        let msg = presentableMessage(for: error)
        presenter.show(msg)
    }

    func presentableMessage(for error: Error) -> String {
        return "Oops, algo deu errado..."
    }
}
