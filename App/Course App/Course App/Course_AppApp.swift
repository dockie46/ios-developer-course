//
//  Course_AppApp.swift
//  Course App
//
//  Created by Patrik Urban on 10.05.2024.
//
import os
import SwiftUI

@main
// swiftlint:disable:next type_name
struct Course_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let logger = Logger()
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: delegate.appCoordinator)
                .ignoresSafeArea(edges: .all)
                .onAppear {
                    logger.info("Content view has appeared")
                }
        }
    }
}
