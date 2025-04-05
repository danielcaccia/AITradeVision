//
//  NotificationManager.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import Foundation
import UserNotifications

final class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestAuthorizationIfNeeded() async {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        
        switch settings.authorizationStatus {
        case .notDetermined:
            await requestAuthorization()
        case .denied:
            print("🔕 Notificações negadas — sugerir ao usuário ir nas configurações.")
        case .authorized, .provisional, .ephemeral:
            print("✅ Notificações já autorizadas.")
        @unknown default:
            break
        }
    }

    private func requestAuthorization() async {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            
            if granted {
                print("✅ Permissão de notificação concedida")
            } else {
                print("❌ Permissão de notificação negada")
            }
        } catch {
            print("⚠️ Erro ao solicitar permissão: \(error)")
        }
    }

    func scheduleNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Erro ao agendar notificação: \(error)")
            }
        }
    }

    func debugPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("🔔 Notificações pendentes: \(requests)")
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
