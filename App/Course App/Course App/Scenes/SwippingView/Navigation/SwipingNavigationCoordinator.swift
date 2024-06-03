//
//  SwipingNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Foundation
import UIKit
import SwiftUI

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    var childCoordinators: [any Coordinator] = [Coordinator]()
    func start() {
        navigationController.setViewControllers([makeSwipingCard()], animated: false)
    }
}

private extension SwipingNavigationCoordinator {
    func makeSwipingCard() -> UIViewController {
        UIHostingController(rootView: SwipingView())
    }
}
