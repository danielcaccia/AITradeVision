//
//  SettingsViewModel.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    private let coordinator: SettingsCoordinator
    
    weak var appCoordinator: AppCoordinator?
    
    init(coordinator: SettingsCoordinator, appCoordinator: AppCoordinator?) {
        self.coordinator = coordinator
        self.appCoordinator = appCoordinator
    }
    
    func goToDashboard() {
        coordinator.switchToMainApp()
    }
    
    func goToUpdateEmail() {
        coordinator.route = .updateEmail
    }

    func goToPreferences() {
        coordinator.route = .preferences
    }

    func goToLanguage() {
        coordinator.route = .language
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
