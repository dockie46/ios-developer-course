//
//  ProfileNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class ProfileNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    var childCoordinators: [any Coordinator] = [Coordinator]()
    var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<ProfileNavigationCoordinatorEvent, Never>()
    func start() {
        navigationController.setViewControllers([makeProfileCard()], animated: false)
    }
}

// MARK: - EventEmitting
extension ProfileNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<ProfileNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

private extension ProfileNavigationCoordinator {
    func makeProfileCard() -> UIViewController {
        let profileView = ProfileView()
        profileView.eventPublisher.sink { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .signOut:
                eventSubject.send(.logout)
            case .onboarding:
                _ = makeOnboardingFlow(navigationController: self.navigationController)
            case .onboardingModal:
                self.navigationController.present(
                    makeOnboardingFlow().rootViewController,
                    animated: true
                )
            }
        }
        .store(in: &cancellables)

        return UIHostingController(rootView: profileView)
    }
    
    func makeOnboardingFlow(navigationController: UINavigationController? = nil) -> ViewControllerCoordinator {
        
        let coordinator = OnboardingNavigationCoordinator(pageIndex: 1, navigationController: navigationController)
        // if navigation controller is injected we need to manage pop events
        if navigationController != nil {
          coordinator.navigationController.delegate = self
        }

        startChildCoordinator(coordinator)

        return coordinator
    }
}

// MARK: - UINavigationControllerDelegate
extension ProfileNavigationCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            if let onboardingCoordinator = childCoordinators.first(where: { $0 is OnboardingCoordinating }) {
                release(coordinator: onboardingCoordinator)
            }
        }
    }
}
