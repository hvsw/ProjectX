//
//  NotificationHelperView.swift
//  ProjectX
//
//  Created by William Hass on 2020-07-01.
//

import SwiftUI

struct NotificationHelperView: View {
    private let notificationHelper: NotificationHelper = NotificationHelper()

    var body: some View {
        VStack(spacing: 16) {
            Button("Request Permission") {
                notificationHelper.requestAuth()
            }
            Button("Schedule Notification with Options") {
                notificationHelper.sendMultipleOptionsNotification()
            }
            Button("Schedule Notification with Input") {
                notificationHelper.sendInputTextNotification()
            }
        }
    }
}
