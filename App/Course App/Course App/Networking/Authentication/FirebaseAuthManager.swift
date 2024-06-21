//
//  FirebaseAuthManager.swift
//  Course App
//
//  Created by Patrik Urban on 13.06.2024.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthManager: FirebaseAuthManaging {
    private let authService = Auth.auth()
    private let keychainService: KeychainServicing
    
    init(keichain: KeychainServicing) {
        keychainService = keichain
    }

    func signUp(_ credentials: Credentials) async throws {
        let result = try await authService.createUser(withEmail: credentials.email, password: credentials.password)
        guard let accessToken = try? await result.user.getIDToken() else {
            return
        }

        try keychainService.storeAuthData(authData: accessToken)
    }
    
    func signIn(_ credentials: Credentials) async throws {
        let result = try await authService.signIn(withEmail: credentials.email, password: credentials.password)
        guard let accessToken = try? await result.user.getIDToken() else {
            return
        }

        try keychainService.storeAuthData(authData: accessToken)
    }
    
    func signOut() async throws {
        try authService.signOut()
        try keychainService.cleanAuthData()
    }
}
