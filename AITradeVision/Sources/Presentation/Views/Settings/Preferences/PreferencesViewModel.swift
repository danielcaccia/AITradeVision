//
//  PreferencesViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import Foundation

final class PreferencesViewModel: ObservableObject {
    weak var appCoordinator: AppCoordinator?
    
    init(appCoordinator: AppCoordinator?) {
        self.appCoordinator = appCoordinator
    }
    
    func logout() async {
        do {
            try await FirebaseAuthService().logout()
            
            await MainActor.run {
                appCoordinator?.currentFlow = .auth
            }
        } catch {
            print("Erro ao deslogar: \(error.localizedDescription)")
        }
    }
}
