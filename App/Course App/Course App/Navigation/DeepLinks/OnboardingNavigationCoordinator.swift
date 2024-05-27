//
//  OnboardingNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Foundation
import Combine
import UIKit
import SwiftUI

enum OnboardingNavigationCoordinatorEvent {
    case dismiss(Coordinator)
}

protocol OnboardingCoordinating: NavigationControllerCoordinator {}

final class OnboardingNavigationCoordinator: NSObject, OnboardingCoordinating {
    deinit {
        print("Deinit OnboardingNavigationCoordinator")
    }
    
    private(set) lazy var navigationController: UINavigationController = makeNavigationController()
    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<OnboardingNavigationCoordinatorEvent, Never>()
    private let initialPage: Int
    var childCoordinators: [any Coordinator] = []
    
    init(initialPage: Int) {
        self.initialPage = initialPage
    }
}

extension OnboardingNavigationCoordinator {
    func makeNavigationController() -> UINavigationController {
        let navigationController = CustomNavigationController()
        navigationController.eventPublisher.sink { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .dismiss:
                self.eventSubject.send(.dismiss(self))
            default:
                break
            }
        }
        .store(in: &cancellables)
        return navigationController
    }
    func start() {
        guard let nextOnboardingPageViewController = nextOnboardingViewController(page: initialPage) else { return }
        navigationController.setViewControllers([nextOnboardingPageViewController], animated: false)
    }
}
// MARK: - EventEmitting
extension OnboardingNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
extension OnboardingCoordinating {
    func navigateToOnboardingView(page: Int) {
        guard let controller = nextOnboardingViewController(page: page) else { return }
        navigationController.pushViewController(controller, animated: true)
    }

    func finishOnboarding() {
        navigationController.dismiss(animated: true)
    }
    
    func nextOnboardingViewController(page: Int) -> UIViewController? {
        var viewController: UIViewController
        switch page {
        case 1:
            viewController = makeOnboardingView()
        case 2:
            viewController = makeOnboardingSecondView()
        case 3:
            viewController = makeOnboardingLastView()
        default:
            return nil
        }
        return viewController
    }
    
    private func makeOnboardingView() -> UIViewController {
        let controller = UIHostingController(rootView: OnboardingViewStart(coordinator: self))
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        return controller
    }
    
    private func makeOnboardingSecondView() -> UIViewController {
        let controller = UIHostingController(rootView: OnboardingViewSecond(coordinator: self))
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        return controller
    }
    
    private func makeOnboardingLastView() -> UIViewController {
        let controller = UIHostingController(rootView: OnboardingViewLast(coordinator: self))
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        return controller
    }
}
