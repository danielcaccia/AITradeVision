//
//  CheckAlertsOperation.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import Foundation

final class CheckAlertsOperation: Operation, @unchecked Sendable {
    override func main() {
        let semaphore = DispatchSemaphore(value: 0)

        Task {
            let checker = await AlertChecker()
            await checker.checkAlerts()
            semaphore.signal()
        }

        semaphore.wait()
    }
}
