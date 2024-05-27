//
//  AppCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Foundation
import UIKit

protocol AppCoordinating: ViewControllerCoordinator {}

final class AppCoordinator: AppCoordinating {
    private(set) lazy var rootViewController = makeTabBarFlow()
    var childCoordinators = [Coordinator]()
}

// MARK: - Start coordinator
extension AppCoordinator {
    func start() {
        setupAppUI()
    }

    func setupAppUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = .white
    }

    func makeTabBarFlow() -> UIViewController {
        let coordinator = MainTabBarCoordinator()
        childCoordinators.append(coordinator)
        coordinator.start()
        return coordinator.rootViewController
    }

    func handleDeeplink(deeplink: DeepLink) {
        childCoordinators.forEach { $0.handleDeeplink(deeplink: deeplink) }
    }
}
