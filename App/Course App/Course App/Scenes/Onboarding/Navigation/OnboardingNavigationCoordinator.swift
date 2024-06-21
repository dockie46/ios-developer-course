//
//  OnboardingNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Foundation
import Combine
import DependencyInjection
import UIKit
import SwiftUI

enum OnboardingNavigationCoordinatorEvent {
    case dismiss(Coordinator)
}

protocol OnboardingCoordinating: NavigationControllerCoordinator {
    func handle(_ event: OnboardingViewEvent)
}

final class OnboardingNavigationCoordinator: NSObject, OnboardingCoordinating {
    
    func handle(_ event: OnboardingViewEvent) {
        switch event {
        case .close:
            if navigationController.presentingViewController != nil {
                // Dismissing is detected on CustomNavigationController and event publisher is subscribed to manage releasing resources properly
                navigationController.dismiss(animated: true)
            } else {
                navigationController.popToRootViewController(animated: true)
            }
        case let .nextPage(from):
            
            var newPage: Page
            if from <= Page.allCases.count  {
                // swiftlint:disable:next force_unwrapping
                newPage = Page(rawValue: from + 1)!
            } else {
                newPage = Page.page1
            }
            
            let viewController = self.makeOnBoardingView(page: newPage)
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    
    private enum Page: Int, CaseIterable {
        case page1 = 1
        case page2 = 2
        case page3 = 3
        
        var title: String {
            switch self {
            case .page1:
                "Page 1"
            case .page2:
                "Page 2"
            case .page3:
                "Page 3"
            }
        }
    }
    
    private(set) lazy var navigationController: UINavigationController = makeNavigationController()
    private var isNavigationControllerInjected: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<OnboardingNavigationCoordinatorEvent, Never>()
    private let pageIndex: Int
    
    var childCoordinators: [any Coordinator] = []
    var container: Container
    
    init(container: Container, pageIndex: Int = 1, navigationController: UINavigationController? = nil) {
        self.pageIndex = pageIndex
        self.container = container
        super.init()
        if let navigationController {
            self.isNavigationControllerInjected = true
            self.navigationController = navigationController
        }
    }
}

extension OnboardingNavigationCoordinator {
    func start() {
        let p = Page(rawValue: pageIndex) ?? Page.page1
        let nextOnboardingPageViewController = makeOnBoardingView(page: p)
        
        if isNavigationControllerInjected {
            navigationController.pushViewController(nextOnboardingPageViewController, animated: true)
        } else {
            navigationController.setViewControllers([nextOnboardingPageViewController], animated: false)
        }
    }
}

private extension OnboardingNavigationCoordinator {
    func makeNavigationController() -> UINavigationController {
        let navigationController = CustomNavigationController()
        navigationController.eventPublisher.sink { [weak self] event in
            self?.handle(event)
        }
        .store(in: &cancellables)
        return navigationController
    }
    
    private func makeOnBoardingView(page: Page) -> UIViewController {
        let onboardingView = OnboardingView(page: page.rawValue, title: page.title, last: page.rawValue == Page.page3.rawValue)
        onboardingView.eventPublisher.sink { [weak self] event in
            self?.handle(event)
        }
        .store(in: &cancellables)
        
        return UIHostingController(rootView: onboardingView)
    }
}

// MARK: - Event handling
private extension OnboardingNavigationCoordinator {
    func handle(_ event: CustomNavigationControllerEvent) {
        switch event {
        case .dismiss:
            self.eventSubject.send(.dismiss(self))
        default:
            break
        }
    }
}



// MARK: - EventEmitting
extension OnboardingNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
