//
//  SigningViewStore.swift
//  Course App
//
//  Created by Patrik Urban on 21.06.2024.
//

import Foundation
import Combine
import os

final class SigningViewStore: ObservableObject, EventEmitting, Store {
    private let logger = Logger()
    private let authManager: FirebaseAuthManaging
    private let eventSubject = PassthroughSubject<SignInViewEvent, Never>()
    @Published var state: SigningViewState = .initial

    init(auth: FirebaseAuthManaging) {
        self.authManager = auth
    }

    var eventPublisher: AnyPublisher<SignInViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension SigningViewStore {
    @MainActor
    func send(_ action: SigningViewAction) {
        switch action {
        case .signIn:
            signIn()
        case .signUp:
            signUp()
        case .logged:
            eventSubject.send(.signedIn)
        }
    }
}


private extension SigningViewStore {
    @MainActor
    func signIn() {
        Task {
            do {
                print(state.email)
                print(state.password)
                try await authManager.signIn(Credentials(email: state.email, password: state.password))
                send(.logged)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func signUp() {
        Task {
            do {
                try await authManager.signUp(Credentials(email: state.email, password: state.password))
                send(.logged)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
