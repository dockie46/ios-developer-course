//
//  AppDelegate.swift
//  Course App
//
//  Created by Patrik Urban on 12.05.2024.
//

import FirebaseCore
import UIKit

enum DeepLink {
    case onboarding(page: Int)
    case closeOnboarding
    case signIn
    case news
}

protocol DeeplinkHandling: AnyObject {
    func handleDeeplink(_ deeplink: Deeplink)
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    weak var deeplinkHandler: DeeplinkHandling?
    
    let appCoordinator: some AppCoordinating = {
        let coordinator = AppCoordinator()
        coordinator.start()
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        deeplinkFromService()
        return true
    }
    func deeplinkFromService() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.appCoordinator.handleDeeplink(deeplink: .onboarding(page: 1))
//            self.appCoordinator.handleDeeplink(deeplink: .news)
        }
    }
}
