//
//  CategoriesNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import Foundation
import UIKit
import SwiftUI

final class CategoriesNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    var childCoordinators: [any Coordinator] = [Coordinator]()
    func start() {
        navigationController.setViewControllers([makeCategories()], animated: false)
    }
}

private extension CategoriesNavigationCoordinator {
    func makeCategories() -> UIViewController {
        HomeViewController()
    }
}
