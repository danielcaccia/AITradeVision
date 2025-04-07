//
//  SettingsCoordinatorTests.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import XCTest
import SwiftUI
@testable import AITradeVision

@MainActor
final class SettingsCoordinatorTests: XCTestCase {
    func buildSUT() -> SettingsCoordinator {
        SettingsCoordinator()
    }

    func testInitialRouteIsProfile() {
        // Arrange
        let sut = buildSUT()
        
        // Assert
        XCTAssertEqual(sut.route, .profile)
    }

    func testBuildCurrentViewProfileDoesNotCrash() {
        // Arrange
        let sut = buildSUT()
        
        // Act
        let _ = sut.buildCurrentView(for: .profile)
    }

    func testBuildCurrentViewPreferencesDoesNotCrash() {
        // Arrange
        let sut = buildSUT()
        
        // Act
        let _ = sut.buildCurrentView(for: .preferences)
    }
}
