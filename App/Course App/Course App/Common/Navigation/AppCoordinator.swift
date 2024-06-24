//
//  AppCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Combine
import DependencyInjection
import Foundation
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
    private lazy var keychainService = KeychainService(keychainManager: KeychainManager())
    
    var container = Container()
    var childCoordinators = [Coordinator]()
    
    @Published var isAuthorizedFlow = false
    
    // MARK: Lifecycle
    init() {
        
    }
}

// MARK: - Start coordinator
extension AppCoordinator {
    func start() {
        setupAppUI()
        assembleDependencyInjectionContainer()
        
        isAuthorizedFlow = (try? container.resolve(type: KeychainServicing.self).fetchAuthData()) != nil
    }
    
    func assembleDependencyInjectionContainer() {
        ManagerRegistration.registerDependencies(to: container)
        ServiceRegistration.registerDependencies(to: container)
        StoreRegistration.registerDependencies(to: container)
    }

    func setupAppUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().isTranslucent = false
    }
    
    func makeSignInFlow() -> ViewControllerCoordinator {
        let signInCoordinator = SignInNavigationCoordinator(container: container)
        startChildCoordinator(signInCoordinator)
        signInCoordinator.eventPublisher.sink { [weak self] event in
            self?.handle(event)
        }
        .store(in: &cancellables)
        return signInCoordinator
    }

    func makeTabBarFlow() -> ViewControllerCoordinator {
        let mainTabCoordinator = MainTabBarCoordinator(container: container)
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
        case let .signedIn(coordinator):
            
            rootViewController = makeTabBarFlow().rootViewController
            release(coordinator: coordinator)
            isAuthorizedFlow = true
        }
    }
}

