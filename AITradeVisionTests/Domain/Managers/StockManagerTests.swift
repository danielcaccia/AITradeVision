//
//  StockManagerTests.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import XCTest
@testable import AITradeVision

class StockManagerTests: XCTestCase {
    var stockManager: StockManager!
    var mockFinanceService: MockFinanceService!
    var mockErrorHandler: MockErrorHandler!
    
    override func setUp() {
        super.setUp()
        mockFinanceService = MockFinanceService()
        mockErrorHandler = MockErrorHandler()
        stockManager = StockManager(financeService: mockFinanceService, errorHandler: mockErrorHandler)
    }
    
    override func tearDown() {
        stockManager = nil
        mockFinanceService = nil
        mockErrorHandler = nil
        super.tearDown()
    }
    
    func testGetStockPriceSuccess() async {
        // Arrange
        let symbol = "AAPL"
        let expectedStockQuote = buildMockedStockQuote(withPrice: 150.0)
        mockFinanceService.stockQuoteToReturn = expectedStockQuote
        
        // Act
        let stockQuoteDTO = await stockManager.getStockPrice(for: symbol)
        
        // Assert
        XCTAssertNotNil(stockQuoteDTO, "Stock price should be returned")
        XCTAssertEqual(stockQuoteDTO?.price, 150.0, "Stock price should be 150.0")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be thrown")
    }
    
    func testGetStockPriceFailure() async {
        // Arrange
        let symbol = "AAPL"
        mockFinanceService.shouldReturnError = true
        
        // Act
        let stockQuoteDTO = await stockManager.getStockPrice(for: symbol)
        
        // Assert
        XCTAssertNil(stockQuoteDTO, "Shouldn't return stock quote in case of error")
        XCTAssertTrue(mockErrorHandler.errorHandled, "The error should be treaten by the ErrorHandler")
    }
    
    func testFetchStockHistorySuccess() async {
        // Arrange
        let symbol = "AAPL"
        let expectedHistory = [buildMockedStockQuote(withPrice: 150.0), buildMockedStockQuote(withPrice: 155.0)]
        mockFinanceService.stockHistoryToReturn = expectedHistory
        
        // Act
        let stockHistoryDTO = await stockManager.fetchStockHistory(for: symbol)
        
        // Assert
        XCTAssertEqual(stockHistoryDTO.count, 2, "StockHistoryDTO should contain 2 stock history items")
        XCTAssertEqual(stockHistoryDTO[0].price, 150.0, "The first stock price should be 150.0")
        XCTAssertEqual(stockHistoryDTO[1].price, 155.0, "The second stock price should be 155.0")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be thrown")
    }
    
    func testFetchStockHistoryFailure() async {
        // Arrange
        let symbol = "AAPL"
        mockFinanceService.shouldReturnError = true
        
        // Act
        let stockHistoryDTO = await stockManager.fetchStockHistory(for: symbol)
        
        // Assert
        XCTAssertTrue(stockHistoryDTO.isEmpty, "Shouldn't return stock history in case of error")
        XCTAssertTrue(mockErrorHandler.errorHandled, "The error should be treaten by the ErrorHandler")
    }
    
    func testStockQuoteTransformation() async {
        // Arrange
        let symbol = "AAPL"
        let expectedStockQuote = buildMockedStockQuote(withPrice: 150.0)
        mockFinanceService.stockQuoteToReturn = expectedStockQuote
        
        // Act
        let stockQuoteDTO = await stockManager.getStockPrice(for: symbol)
        
        // Assert
        XCTAssertNotNil(stockQuoteDTO, "StockQuoteDTO should be returned")
        XCTAssertEqual(stockQuoteDTO?.price, 150.0, "StockQuoteDTO price should be 150.0")
    }
    
    func testErrorHandlerCalledOnError() async {
        // Arrange
        let symbol = "AAPL"
        mockFinanceService.shouldReturnError = true
        
        // Act
        _ = await stockManager.getStockPrice(for: symbol)
        
        // Assert
        XCTAssertTrue(mockErrorHandler.errorHandled, "The ErrorHandler should be called in case of error")
    }
}

extension StockManagerTests {
    private func buildMockedStockQuote(withPrice: Double) -> StockQuote{
        return StockQuote(
            symbol: "AAPL",
            history: HistoricQuote(
                date: "01-01-2025",
                openPrice: 0.0,
                highPrice: 0.0,
                lowPrice: 0.0,
                closePrice: withPrice,
                volume: 1
            )
        )
    }
}
