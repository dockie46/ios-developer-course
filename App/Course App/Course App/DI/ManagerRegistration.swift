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
        
#if DEBUG
        if ProcessInfo.processInfo.environment["UITEST"] == "1" {
            container.autoregister(
                type: FirebaseAuthManaging.self,
                in: .shared,
                initializer: MockFirebaseAuthManager.init)
        } else {
            container.autoregister(
                type: FirebaseAuthManaging.self,
                in: .shared,
                initializer: FirebaseAuthManager.init)
        }
#else
        container.autoregister(
            type: FirebaseAuthManaging.self,
            in: .shared,
            initializer: FirebaseAuthManager.init)
#endif
        
#if DEBUG
        if ProcessInfo.processInfo.environment["UITEST"] == "1" {
            container.autoregister(
                type: KeychainManaging.self,
                in: .shared,
                initializer: MockKeychainManager.init
            )
        } else {
            container.autoregister(
                type: KeychainManaging.self,
                in: .shared,
                initializer: KeychainManager.init
            )
        }
#else
        container.autoregister(
            type: KeychainManaging.self,
            in: .shared,
            initializer: KeychainManager.init
        )
#endif
        
        
        container.autoregister(
            type: APIManaging.self,
            in: .shared,
            initializer: APIManager.init
        )
    }
}
