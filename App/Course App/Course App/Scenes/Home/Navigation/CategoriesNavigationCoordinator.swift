//
//  CategoriesNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import Foundation
import Combine
import DependencyInjection
import os
import UIKit
import SwiftUI

final class CategoriesNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let logger = Logger()
    
    var container: Container
    var childCoordinators: [any Coordinator] = [Coordinator]()
    
    func start() {
        navigationController.setViewControllers([makeCategories()], animated: false)
    }
    
    deinit {
        logger.info("Deinit HomeViewCoordinator")
    }
    
    init(container: Container) {
        self.container = container
    }
}

private extension CategoriesNavigationCoordinator {
    func makeCategories() -> UIViewController {
        let homeView = HomeViewController()
        homeView.eventPublisher.sink { [weak self] event in
            self?.handle(event)
        }
        .store(in: &cancellables)
        return homeView
    }
}

// MARK: - Handling events
private extension CategoriesNavigationCoordinator {
    func handle(_ event: HomeViewEvent) {
        switch event {
        case let .itemSelected(joke):
            logger.info("Joke on home screen was tapped \(joke.text)")
            navigationController.pushViewController(makeSwipingView(), animated: true)
        }
    }
    
    func makeSwipingView() -> UIViewController {
        let store = container.resolve(type: SwipingViewStore.self)
        store.eventPublisher.sink { [weak self] event in
            self?.handleSwipingViewEvent(event)
        }
        .store(in: &cancellables)

        return UIHostingController(rootView: SwipingView(store: store))
    }
    
    func handleSwipingViewEvent(_ event: SwipingViewEvent) {
        switch event {
        case .dismiss:
            navigationController.popToRootViewController(animated: true)
        }
    }
}
