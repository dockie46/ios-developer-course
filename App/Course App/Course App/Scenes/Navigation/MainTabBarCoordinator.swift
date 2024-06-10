//
//  MainTabBarCoordinator.swift
//  Course App
//
//  Created by Work on 25.05.2024.
//
import Combine
import Foundation
import UIKit
import SwiftUI

final class MainTabBarCoordinator: NSObject, TabBarControllerCoordinator {
    var childCoordinators = [Coordinator]()
    private(set) lazy var tabBarController = makeTabBarController()   
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<MainTabBarCoordinatorEvent, Never>()
    
    deinit {
        print("MainTabBarCoordinator")
    }
}

// MARK: - EventEmitting
extension MainTabBarCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<MainTabBarCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Start coordinator
extension MainTabBarCoordinator {
    func start() {
        tabBarController.viewControllers = [
            setupCategoriesView(),
            setupSwipingCardView(),
            setupProfileView()
        ]
    }
    
    func handleDeeplink(deeplink: DeepLink) {
        switch deeplink {
        case let .onboarding(page):
            let coordinator = makeOnboardingFlow(pageIndex: page)
            startChildCoordinator(coordinator)
            tabBarController.present(coordinator.rootViewController, animated: true)
        case .news:
            let coordinator = makeNewsFlow()
            startChildCoordinator(coordinator)
            tabBarController.present(coordinator.rootViewController, animated: true)
        default:
            break
        }
    }
}

// MARK: Factory methods
private extension MainTabBarCoordinator {
    func makeOnboardingFlow(pageIndex: Int) -> ViewControllerCoordinator {
        let coordinator = OnboardingNavigationCoordinator(pageIndex: pageIndex)
        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)
        return coordinator
    }
    func makeNewsFlow() -> ViewControllerCoordinator {
        let coordinator = NewsNavigationCoordinator()
        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)
        return coordinator
    }
    
    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        return tabBarController
    }

    func setupCategoriesView() -> UIViewController {
        let categoriesCoordinator = CategoriesNavigationCoordinator()
        startChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.dash.header.rectangle"),
            tag: 0
        )
        return categoriesCoordinator.rootViewController
    }

    func setupSwipingCardView() -> UIViewController {
        let swippingCoordinator = SwipingNavigationCoordinator()
        startChildCoordinator(swippingCoordinator)
        swippingCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "switch.2"), tag: 1)
        return swippingCoordinator.rootViewController
    }
    func setupProfileView() -> UIViewController {
        let profileCoordinator = ProfileNavigationCoordinator()
        startChildCoordinator(profileCoordinator)
        profileCoordinator.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)
        profileCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        return profileCoordinator.rootViewController
    }
}

// MARK: - Handling events
private extension MainTabBarCoordinator {
    func handle(event: OnboardingNavigationCoordinatorEvent) {
        switch event {
        case let .dismiss( coordinator):
            release(coordinator: coordinator)
        }
    }
    
    func handle(event: ProfileNavigationCoordinatorEvent) {
        switch event {
        case .logout:
            eventSubject.send(.logout(self))
        }
    }
}

extension MainTabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if viewController === tabBarController.viewControllers?.last {
//           rootViewController.showInfoAlert(title: "Ups something is wrong...")
        }
    }
}

extension UIViewController {
    
    func showInfoAlert(title: String, message: String? = nil, handler: (() -> Void)? = nil) {
        guard presentedViewController == nil else {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            handler?()
        }
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
}
