//
//  AuthCoordinatorTests.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import XCTest
import SwiftUI
@testable import AITradeVision

@MainActor
final class AuthCoordinatorTests: XCTestCase {
    func buildSUT() -> (AuthCoordinator, MockAppCoordinator) {
        let mockAppCoordinator = MockAppCoordinator()
        let sut = AuthCoordinator(appCoordinator: mockAppCoordinator)
        return (sut, mockAppCoordinator)
    }

    // MARK: - Tests

    func testInitialRouteIsLogin() {
        // Arrange
        let (sut, _) = buildSUT()
        
        // Assert
        XCTAssertEqual(sut.route, .login)
    }

    func testSwitchToMainAppSetsAppCoordinatorFlowToMarket() {
        // Arrange
        let (sut, appCoordinator) = buildSUT()
        
        // Act
        sut.switchToMainApp()
        
        // Assert
        XCTAssertEqual(appCoordinator.currentFlow, .market)
    }

    func testBuildCurrentViewLoginReturnsLoginView() {
        // Arrange
        let (sut, _) = buildSUT()
        
        // Act
        let _ = sut.buildCurrentView(for: .login)
    }

    func testBuildCurrentViewRegisterReturnsRegisterView() {
        // Arrange
        let (sut, _) = buildSUT()
        
        // Act
        let _ = sut.buildCurrentView(for: .register)
    }
}
