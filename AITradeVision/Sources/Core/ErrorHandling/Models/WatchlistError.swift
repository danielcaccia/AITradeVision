//
//  WatchlistError.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 19/04/25.
//

import Foundation

enum WatchlistError: Error {
    case symbolDoesNotExist
    case symbolAlreadyOnTheList
    
    var friendlyDescription: String {
        switch self {
        case .symbolDoesNotExist:
            return "Selected symbol does not exist."
        case .symbolAlreadyOnTheList:
            return "Symbol is already saved on the user's watchlist."
        }
    }
}
