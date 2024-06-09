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

    var body: some View {
        Form {
            TextField("Email", text: $email)
            TextField("Password", text: $password)
                .textContentType(.password)
            Button("Sign in") {
                eventSubject.send(.signedIn)
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
