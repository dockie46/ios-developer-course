//
//  SignInView.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//
import Combine
import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    private let eventSubject = PassthroughSubject<SignInViewEvent, Never>()
    private let authManager = FirebaseAuthManager()
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
            TextField("Password", text: $password)
                .textContentType(.password)
            
            Button("Sign in") {
                signIn()
            }
            Button("Sign up") {
                signUp()
            }
        }
    }
}

private extension SignInView {
    @MainActor
    func signIn() {
        Task {
            do {
                try await authManager.signIn(Credentials(email: email, password: password))
                eventSubject.send(.signedIn)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func signUp() {
        Task {
            do {
                try await authManager.signUp(Credentials(email: email, password: password))
                eventSubject.send(.signedIn)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - EventEmitting
extension SignInView: EventEmitting {
    var eventPublisher: AnyPublisher<SignInViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

#Preview {
    SignInView()
}
