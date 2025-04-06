//
//  SentimentManagerTests.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import XCTest
@testable import AITradeVision

class SentimentManagerTests: XCTestCase {
    var sentimentManager: SentimentManager!
    var mockSentimentAnalysisService: MockSentimentAnalysisService!
    var mockErrorHandler: MockErrorHandler!
    
    override func setUp() {
        super.setUp()
        mockSentimentAnalysisService = MockSentimentAnalysisService()
        mockErrorHandler = MockErrorHandler()
        sentimentManager = SentimentManager(sentimentAnalysisService: mockSentimentAnalysisService, errorHandler: mockErrorHandler)
    }
    
    override func tearDown() {
        sentimentManager = nil
        mockSentimentAnalysisService = nil
        mockErrorHandler = nil
        super.tearDown()
    }
    
    func testAnalyzeSentimentSuccessPositive() async {
        // Arrange
        let text = "I love this product!"
        mockSentimentAnalysisService.sentimentToReturn = .positive
        
        // Act
        let sentimentDTO = await sentimentManager.analyzeSentiment(for: text)
        
        // Assert
        XCTAssertEqual(sentimentDTO.text, Sentiment.positive.text, "The returned sentiment should be positive")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be thrown")
    }
    
    func testAnalyzeSentimentSuccessNegative() async {
        // Arrange
        let text = "I hate this product!"
        mockSentimentAnalysisService.sentimentToReturn = .negative
        
        // Act
        let sentimentDTO = await sentimentManager.analyzeSentiment(for: text)
        
        // Assert
        XCTAssertEqual(sentimentDTO.text, Sentiment.negative.text, "The returned sentiment should be negative")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be thrown")
    }
    
    func testAnalyzeSentimentFailure() async {
        // Arrange
        let text = "I don't know how I feel about this."
        mockSentimentAnalysisService.shouldReturnError = true
        
        // Act
        let sentimentDTO = await sentimentManager.analyzeSentiment(for: text)
        
        // Assert
        XCTAssertEqual(sentimentDTO.text, Sentiment.neutral.text, "The returned sentiment should be neutral in case of error")
        XCTAssertTrue(mockErrorHandler.errorHandled, "The error should be treaten by the ErrorHandler")
    }
    
    func testAnalyzeSentimentEmptyText() async {
        // Arrange
        let text = ""
        mockSentimentAnalysisService.sentimentToReturn = .neutral
        
        // Act
        let sentimentDTO = await sentimentManager.analyzeSentiment(for: text)
        
        // Assert
        XCTAssertEqual(sentimentDTO.text, Sentiment.neutral.text, "The returned sentiment for empty text should be neutral")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be thrown")
    }
    
    func testAnalyzeSentimentNilResponse() async {
        // Arrange
        let text = "This is a sentence with no sentiment."
        mockSentimentAnalysisService.sentimentToReturn = nil
        
        // Act
        let sentimentDTO = await sentimentManager.analyzeSentiment(for: text)
        
        // Assert
        XCTAssertEqual(sentimentDTO.text, Sentiment.neutral.text, "The returned sentiment should be neutral in case the service returns nil")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be throwno")
    }
    
    func testAnalyzeSentimentErrorHandlerCalled() async {
        // Arrange
        let text = "I feel conflicted about this."
        mockSentimentAnalysisService.shouldReturnError = true
        
        // Act
        _ = await sentimentManager.analyzeSentiment(for: text)
        
        // Assert
        XCTAssertTrue(mockErrorHandler.errorHandled, "The ErrorHandler should be called in case of error")
    }
}
