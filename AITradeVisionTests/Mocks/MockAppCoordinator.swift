//
//  MockAppCoordinator.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation
@testable import AITradeVision

class MockAppCoordinator: AppCoordinator {
    override var currentFlow: Flow {
        get { flow }
        set { flow = newValue }
    }

    private var flow: Flow = .market
}
