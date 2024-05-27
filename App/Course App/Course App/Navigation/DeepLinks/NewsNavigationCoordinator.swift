//
//  NewsNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import Combine
import Foundation
import SwiftUI

protocol NewsCoordinating: NavigationControllerCoordinator {}

final class NewsNavigationCoordinator: NSObject, NewsCoordinating {
    
    deinit {
        print("Deinit OnboardingNavigationCoordinator")
    }
    
    private(set) lazy var navigationController: UINavigationController = makeNavigationController()
    private var cancellables = Set<AnyCancellable>()
    var childCoordinators: [any Coordinator] = []
}

extension NewsNavigationCoordinator {
    func makeNavigationController() -> UINavigationController {
        let navigationController = CustomNavigationController()
        //        navigationController.eventPublisher.sink { [weak self] value in
        //            guard let self else {
        //                return
        //            }
        //            self.eventSubject.send(.dismiss(self))
        //        }
        return navigationController
    }
    func start() {
        navigationController.setViewControllers([makeOnboardingView()], animated: false)
    }
    func makeOnboardingView() -> UIViewController {
        let controller = UIHostingController(rootView: NewsView())
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        return controller
    }
}
