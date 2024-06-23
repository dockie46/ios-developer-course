//
//  SignInView.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//
import Combine
import SwiftUI

struct SignInView: View {
    
    @StateObject private var store: SigningViewStore
    
    init(store: SigningViewStore) {
        _store = .init(wrappedValue: store)
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $store.state.email)
            SecureField("Password", text: $store.state.password)
            
            Button("Sign in") {
                store.send(.signIn)
            }
            Button("Sign up") {
                store.send(.signUp)
            }
        }
    }
}
