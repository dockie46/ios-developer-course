//
//  ManagerRegistration.swift
//  Course App
//
//  Created by Patrik Urban on 20.06.2024.
//
import DependencyInjection
import Foundation

enum ManagerRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            type: StoreManaging.self,
            in: .shared,
            initializer: FirebaseStoreManager.init
        )
        
        container.autoregister(
            type: FirebaseAuthManaging.self,
            in: .shared,
            initializer: FirebaseAuthManager.init)

        container.autoregister(
            type: KeychainManaging.self,
            in: .shared,
            initializer: KeychainManager.init
        )

        container.autoregister(
            type: APIManaging.self,
            in: .shared,
            initializer: APIManager.init
        )
    }
}
