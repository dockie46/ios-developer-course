//
//  SignInNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation
import Combine
import os
import UIKit
import SwiftUI

protocol SignInCoordinating: NavigationControllerCoordinator {}

final class SignInNavigationCoordinator: SignInCoordinating {

    private(set) lazy var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<SignInNavigationCoordinatorEvent, Never>()
    private let logger = Logger()

    // MARK: Public properties
    var childCoordinators: [any Coordinator] = []

    // MARK: Lifecycle
    deinit {
        logger.info("Deinit SingInNavigationCoordinator")
    }
}


// MARK: - EventEmitting
extension SignInNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<SignInNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Start coordinator
extension SignInNavigationCoordinator {
    func start() {
        navigationController.setViewControllers(
            [makeSignInView()],
            animated: false
        )
    }
}

// MARK: - Factory methods
private extension SignInNavigationCoordinator {
    private func makeSignInView() -> UIViewController {
        let signInView = SignInView()
        signInView.eventPublisher.sink { [weak self] event in
            self?.handle(event)
        }
        .store(in: &cancellables)

        return UIHostingController(rootView: signInView)
    }
}

// MARK: - Event handling
private extension SignInNavigationCoordinator {
    func handle(_ event: SignInViewEvent) {
        switch event {
        case .signedIn:
            eventSubject.send(.signedIn(self))
        }
    }
}
