//
//  MockAuthManager.swift
//  Course App
//
//  Created by Work on 23.06.2024.
//

import Foundation
import os
// Mock implementation of FirebaseAuthManaging
class MockFirebaseAuthManager: FirebaseAuthManaging {
    private let logger = Logger()
    
    init() {}
    
    func signUp(_ credentials: Credentials) async throws {
        logger.info("signup dummy")
    }

    func signIn(_ credentials: Credentials) async throws {
        if credentials.email != "test@test.com" && credentials.password != "test" {
            throw NSError(domain: "MockFirebaseAuthManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error signing in"])
        }
         logger.info("signing")
    }

    func signOut() async throws {
        logger.info("signout")
    }
}
