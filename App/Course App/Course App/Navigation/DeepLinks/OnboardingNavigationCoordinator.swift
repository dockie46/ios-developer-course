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
    
    deinit {
        print("Deinit OnboardingNavigationCoordinator")
    }
    
    private(set) lazy var navigationController: UINavigationController = makeNavigationController()
    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<OnboardingNavigationCoordinatorEvent, Never>()
    private let pageIndex: Int
    var childCoordinators: [any Coordinator] = []
    
    init(pageIndex: Int) {
        self.pageIndex = pageIndex
    }
}
extension OnboardingNavigationCoordinator {
    func start() {
        
        let p = Page(rawValue: pageIndex) ?? Page.page1
        let nextOnboardingPageViewController = makeOnBoardingView(page: p)
        navigationController.setViewControllers([nextOnboardingPageViewController], animated: false)
    }
}

private extension OnboardingNavigationCoordinator {
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
    
    private func makeOnBoardingView(page: Page) -> UIViewController {
        let onboardingView = OnboardingView(page: page.rawValue, title: page.title, last: page.rawValue == Page.page3.rawValue)
        onboardingView.eventPublisher.sink { [weak self] event in
            
            guard let self else {
                return
            }
            
            switch event {
            case .close:
                self.navigationController.dismiss(animated: true)
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
        .store(in: &cancellables)
        
        return UIHostingController(rootView: onboardingView)
    }
}

// MARK: - EventEmitting
extension OnboardingNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
