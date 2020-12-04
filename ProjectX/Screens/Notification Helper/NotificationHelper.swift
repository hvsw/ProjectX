//
//  NotificationHelper.swift
//  ProjectX
//
//  Created by William Hass on 2020-07-01.
//

import UIKit

struct NotificationHelper {

    func requestAuth() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                registerNotificationCategories()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func sendInputTextNotification() {
        sendNotification(NotificationCategoryWithInput().content())
    }

    func sendMultipleOptionsNotification() {
        sendNotification(NotificationCategoryWithOptions().content())
    }

    private func sendNotification(_ notificationContent: UNMutableNotificationContent) {
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notificationContent,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    private func registerNotificationCategories() {
        UNUserNotificationCenter.current()
            .setNotificationCategories([
                NotificationCategoryWithInput().category(),
                NotificationCategoryWithOptions().category()
            ])
    }
}

// Notifications mocks
struct NotificationCategoryWithOptions {
    let identifier: String = "notification_with_options"

    func category() -> UNNotificationCategory {
        // Escala de Humor de Brunel
        let actionNames = [
            "Nada",
            "Um pouco",
            "Moderadamente",
            "Bastante",
            "Extremamente"
        ]
        let actions = actionNames.map {
            UNNotificationAction(
                identifier: UNNotificationDefaultActionIdentifier,
                title: $0,
                options: UNNotificationActionOptions.foreground
            )
        }
        return UNNotificationCategory(
            identifier: identifier,
            actions: actions,
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
    }
    
    func content() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Ansiedade"
        content.subtitle = "Quão ansioso você está se sentindo?"
        content.categoryIdentifier = identifier
        return content
    }
}

struct NotificationCategoryWithInput {
    let identifier: String = "notification_with_input"

    func category() -> UNNotificationCategory {
        let otherAction: UNNotificationAction = {
            UNTextInputNotificationAction(
                identifier: identifier,
                title: "",
                options: .foreground,
                textInputButtonTitle: "Enviar",
                textInputPlaceholder: "Ansioso, irritado, desanimado..."
            )
        }()
        return UNNotificationCategory(
            identifier: identifier,
            actions: [otherAction],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
    }

    func content() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Sintomas"
        content.subtitle = "Como você está se sentindo?"
        content.categoryIdentifier = identifier
        return content
    }
}
