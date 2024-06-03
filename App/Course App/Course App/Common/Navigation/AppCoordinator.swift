//
//  AppCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Foundation
import Combine
import UIKit

protocol AppCoordinating: ViewControllerCoordinator {}

final class AppCoordinator: AppCoordinating, ObservableObject {
    
    private(set) lazy var rootViewController: UIViewController = {
        if isAuthorizedFlow {
            makeTabBarFlow().rootViewController
        } else {
            makeSignInFlow().rootViewController
        }
    }()
    
    private lazy var cancellables = Set<AnyCancellable>()
    var childCoordinators = [Coordinator]()
    @Published var isAuthorizedFlow = false
    
    // MARK: Lifecycle
    init() {}
}

// MARK: - Start coordinator
extension AppCoordinator {
    func start() {
        setupAppUI()
    }

    func setupAppUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    func makeSignInFlow() -> ViewControllerCoordinator {
        let signInCoordinator = SignInNavigationCoordinator()
        startChildCoordinator(signInCoordinator)
        signInCoordinator.eventPublisher.sink { [weak self] event in
            self?.handle(event)
        }
        .store(in: &cancellables)
        return signInCoordinator
    }

    func makeTabBarFlow() -> ViewControllerCoordinator {
        let mainTabCoordinator = MainTabBarCoordinator()
        startChildCoordinator(mainTabCoordinator)
        mainTabCoordinator.eventPublisher.sink { [weak self] event in
            self?.handle(event)
        }
        .store(in: &cancellables)
        return mainTabCoordinator
    }
}

// MARK: - Event handling
private extension AppCoordinator {
    func handle(_ event: MainTabBarCoordinatorEvent) {
        switch event {
        case let .logout(coordinator):
            rootViewController = makeSignInFlow().rootViewController
            release(coordinator: coordinator)
            isAuthorizedFlow = false
        }
    }
    
    func handle(_ event: SignInNavigationCoordinatorEvent) {
        switch event {
        case let .signedIn(coordinator, email, password):
            
            rootViewController = makeTabBarFlow().rootViewController
            release(coordinator: coordinator)
            isAuthorizedFlow = true
            
            do {
                try! KeychainManager().store(key: KeychainManager.key_username, value: email)
                try! KeychainManager().store(key: KeychainManager.key_password, value: password)
                
            } catch {
                
            }
        }
    }
}

