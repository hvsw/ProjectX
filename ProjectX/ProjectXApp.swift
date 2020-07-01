//
//  ProjectXApp.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI
import UserNotifications

@main
struct ProjectXApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink("App", destination: PatientsListView())
                    NavigationLink("Debug notification", destination: NotificationHelperView())
                }
                .navigationTitle("Project X")
            }
        }
    }
}
