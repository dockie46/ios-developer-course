//
//  MainTabBarCoordinator.swift
//  Course App
//
//  Created by Work on 25.05.2024.
//

import Foundation
import UIKit
import SwiftUI

final class MainTabBarCoordinator: NSObject, TabBarControllerCoordinator {
    var childCoordinators = [Coordinator]()
    private(set) lazy var tabBarController = makeTabBarController()
}

// MARK: - Start coordinator
extension MainTabBarCoordinator {
    func start() {
        tabBarController.viewControllers = [
            setupCategoriesView(),
            setupSwipingCardView()
        ]
    }
}

// MARK: Factory methods
private extension MainTabBarCoordinator {
    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        return tabBarController
    }

    func setupCategoriesView() -> UIViewController {
        let categoriesNavigationController = UINavigationController(rootViewController: HomeViewController())
        categoriesNavigationController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.dash.header.rectangle"),
            tag: 0
        )
        return categoriesNavigationController
    }

    func setupSwipingCardView() -> UIViewController {
        let swipingNavigationController = UINavigationController(rootViewController: UIHostingController(rootView: SwipingView()))
        swipingNavigationController.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "switch.2"), tag: 1)
        return swipingNavigationController
    }
}

extension MainTabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if viewController === tabBarController.viewControllers?.last {
//            rootViewController.showInfoAlert(title: "Ups something is wrong...")
        }
    }
}
