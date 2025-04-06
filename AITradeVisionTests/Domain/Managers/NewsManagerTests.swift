//
//  NewsManagerTests.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import XCTest
@testable import AITradeVision

class NewsManagerTests: XCTestCase {
    
    var newsManager: NewsManager!
    var mockNewsService: MockNewsService!
    var mockErrorHandler: MockErrorHandler!
    
    override func setUp() {
        super.setUp()
        mockNewsService = MockNewsService()
        mockErrorHandler = MockErrorHandler()
        newsManager = NewsManager(newsService: mockNewsService, errorHandler: mockErrorHandler)
    }
    
    override func tearDown() {
        newsManager = nil
        mockNewsService = nil
        mockErrorHandler = nil
        super.tearDown()
    }
    
    func testFetchNewsSuccess() async {
        // Arrange
        let symbol = "AAPL"
        let expectedArticle = NewsArticle(title: "Article 1", description: "Content 1")
        mockNewsService.articlesToReturn = [expectedArticle]
        
        // Act
        let articles = await newsManager.fetchNews(for: symbol)
        
        // Assert
        XCTAssertEqual(articles.count, 1, "Should return 1 news article")
        XCTAssertEqual(articles[0].title, "Article 1", "The title of the article should be 'Article 1'")
        XCTAssertEqual(articles[0].description, "Content 1", "The content of the article should be 'Content 1'")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be thrown")
    }
    
    func testFetchNewsFailure() async {
        // Arrange
        let symbol = "AAPL"
        mockNewsService.shouldReturnError = true
        
        // Act
        let articles = await newsManager.fetchNews(for: symbol)
        
        // Assert
        XCTAssertEqual(articles.count, 0, "Shouldn't return articles in case of error")
        XCTAssertTrue(mockErrorHandler.errorHandled, "The error should be treaten by the ErrorHandler")
    }
    
    func testFetchNewsNoArticles() async {
        // Arrange
        let symbol = "AAPL"
        mockNewsService.articlesToReturn = []
        
        // Act
        let articles = await newsManager.fetchNews(for: symbol)
        
        // Assert
        XCTAssertEqual(articles.count, 0, "Should return an empty list of articles")
        XCTAssertFalse(mockErrorHandler.errorHandled, "The error shouldn't be thrown")
    }
    
    func testNewsArticleTransformation() async {
        // Arrange
        let symbol = "AAPL"
        let expectedArticle = NewsArticle(title: "Article 1", description: "Content 1")
        mockNewsService.articlesToReturn = [expectedArticle]
        
        // Act
        let articlesDTO = await newsManager.fetchNews(for: symbol)
        
        // Assert
        XCTAssertEqual(articlesDTO.count, 1, "Should return 1 news articleDTO")
        XCTAssertEqual(articlesDTO[0].title, "Article 1", "The title of the articleDTO should be 'Article 1'")
        XCTAssertEqual(articlesDTO[0].description, "Content 1", "The content of the articleDTO should be 'Content 1'")
    }
    
    func testFetchNewsErrorHandlerCalled() async {
        // Arrange
        let symbol = "AAPL"
        mockNewsService.shouldReturnError = true
        
        // Act
        _ = await newsManager.fetchNews(for: symbol)
        
        // Assert
        XCTAssertTrue(mockErrorHandler.errorHandled, "The ErrorHandler should be called in case of error")
    }
}
