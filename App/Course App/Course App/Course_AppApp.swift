//
//  Course_AppApp.swift
//  Course App
//
//  Created by Patrik Urban on 10.05.2024.
//

import SwiftUI

@main
// swiftlint:disable:next type_name
struct Course_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
