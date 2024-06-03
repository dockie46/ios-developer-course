//
//  ViewControllerCoordinator.swift
//  Course App
//
//  Created by Work on 25.05.2024.
//

import UIKit

protocol ViewControllerCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
}

extension ViewControllerCoordinator {
    
    func showError(title: String) {
        rootViewController.showInfoAlert(title: title)
    }
}

protocol NavigationControllerCoordinator: ViewControllerCoordinator {
    var navigationController: UINavigationController { get }
}

extension NavigationControllerCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }
}

protocol TabBarControllerCoordinator: ViewControllerCoordinator {
    var tabBarController: UITabBarController { get }
}
extension TabBarControllerCoordinator {
    var rootViewController: UIViewController {
        tabBarController
    }
}
