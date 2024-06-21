//
//  SwipingNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//
import Combine
import DependencyInjection
import Foundation
import os
import UIKit
import SwiftUI

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    var childCoordinators: [any Coordinator] = [Coordinator]()
    var container: Container
    var cancellables = Set<AnyCancellable>()
    
    private let logger = Logger()
    func start() {
        navigationController.setViewControllers([makeSwipingCard()], animated: false)
    }
    deinit {
        logger.info("Deinit SingInNavigationCoordinator")
    }

    init(container: Container) {
        self.container = container
    }
}

// MARK: - SwipingViewEvent handling
extension SwipingNavigationCoordinator {
    func handleSwipingViewEvent(_ event: SwipingViewEvent) {
        switch event {
        case .dismiss:
            navigationController.popToRootViewController(animated: true)
        }
    }
}


private extension SwipingNavigationCoordinator {
    func makeSwipingCard() -> UIViewController {
        let store = container.resolve(type: SwipingViewStore.self)
        store.eventPublisher.sink { [weak self] event in
            self?.handleSwipingViewEvent(event)
        }
        .store(in: &cancellables)

        return UIHostingController(rootView: SwipingView(store: store))
    }
}
