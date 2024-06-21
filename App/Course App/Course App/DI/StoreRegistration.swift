//
//  StoreRegistration.swift
//  Course App
//
//  Created by Patrik Urban on 21.06.2024.
//
import DependencyInjection
import Foundation

enum StoreRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            type: SwipingViewStore.self,
            in: .new,
            initializer: SwipingViewStore.init
        )
        
        container.autoregister(type: SigningViewStore.self, in: .new, initializer: SigningViewStore.init)
    }
}
