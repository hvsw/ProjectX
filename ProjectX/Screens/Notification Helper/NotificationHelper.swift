//
//  NotificationHelper.swift
//  ProjectX
//
//  Created by William Hass on 2020-07-01.
//

import UIKit

struct NotificationHelper {

    private enum Notification: String {
        case withInput = "notification_with_input"
        case withOptions = "notification_with_options"
        
        var title: String {
            switch self {
            case .withInput:
                return "Titulo com input"
            case .withOptions:
                return "Titulo com options"
            }
        }
        
        var subtitle: String {
            switch self {
            case .withInput:
                return "Subtitulo com input"
            case .withOptions:
                return "Subtitulo com options"
            }
        }
    }

    func requestAuth() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
                registerNotificationCategories()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func sendInputTextNotification() {
        sendNotification(.withInput)
    }

    func sendMultipleOptionsNotification() {
        sendNotification(.withOptions)
    }

    private func sendNotification(_ notification: Notification) {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.subtitle = notification.subtitle
        content.categoryIdentifier = notification.rawValue

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    private func notificationWithOptionsCategory() -> UNNotificationCategory {
        let notification = Notification.withOptions
        let actionNames = [
            "Agitado",
            "Motivado",
            "Cansado",
            "Desanimado"
        ]
        let actions = actionNames.map {
            UNNotificationAction(
                identifier: UNNotificationDefaultActionIdentifier,
                title: $0,
                options: UNNotificationActionOptions.foreground
            )
        }
        return UNNotificationCategory(
            identifier: notification.rawValue,
            actions: actions,
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
    }

    private func notificationWithInputCategory() -> UNNotificationCategory {
        let notification = Notification.withInput
        let otherAction: UNNotificationAction = {
            UNTextInputNotificationAction(
                identifier: "",
                title: "Diga algo",
                options: .foreground,
                textInputButtonTitle: "Enviar",
                textInputPlaceholder: "Como você está se sentindo?"
            )
        }()
        return UNNotificationCategory(
            identifier: notification.rawValue,
            actions: [otherAction],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
    }

    private func registerNotificationCategories() {
        UNUserNotificationCenter.current()
            .setNotificationCategories([
                notificationWithOptionsCategory(),
                notificationWithInputCategory()
            ])
    }
}
