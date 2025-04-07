//
//  MarketCoordinatorTests.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import XCTest
import SwiftUI
@testable import AITradeVision

@MainActor
final class MarketCoordinatorTests: XCTestCase {
    func buildSUT() -> (MarketCoordinator, MockAppCoordinator) {
        let mockAppCoordinator = MockAppCoordinator()
        let sut = MarketCoordinator()
        sut.appCoordinator = mockAppCoordinator
        return (sut, mockAppCoordinator)
    }

    // MARK: - Tests

    func testInitialRouteIsMarketDashboard() {
        // Arrange
        let (sut, _) = buildSUT()
        
        // Assert
        XCTAssertEqual(sut.route, .marketDashboard)
    }

    func testBuildCurrentViewMarketDashboardDoesNotCrash() {
        // Arrange
        let (sut, _) = buildSUT()
        
        // Act
        let _ = sut.buildCurrentView(for: .marketDashboard)
    }

    func testBuildCurrentViewSentimentAnalysisDoesNotCrash() {
        // Arrange
        let (sut, _) = buildSUT()
        
        // Act
        let _ = sut.buildCurrentView(for: .sentimentAnalysis(stockSymbol: "AAPL"))
    }

    func testBuildCurrentViewStockHistoryDoesNotCrash() {
        // Arrange
        let (sut, _) = buildSUT()
        
        // Act
        let _ = sut.buildCurrentView(for: .stockHistory(stockSymbol: "GOOG"))
    }
}
