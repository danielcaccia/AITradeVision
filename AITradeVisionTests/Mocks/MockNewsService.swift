//
//  MockNewsService.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import Foundation
@testable import AITradeVision

class MockNewsService: NewsServiceProtocol {
    var shouldReturnError = false
    var articlesToReturn: [NewsArticle] = []
    
    func fetchNews(for symbol: String) async throws -> [NewsArticle] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return articlesToReturn
    }
}
