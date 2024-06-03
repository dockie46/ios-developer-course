//
//  Coordinator.swift
//  Course App
//
//  Created by Work on 25.05.2024.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func handleDeeplink(deeplink: DeepLink)
}

extension Coordinator {
    func release(coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }

    func startChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    func handleDeeplink(deeplink: DeepLink) {}
}
