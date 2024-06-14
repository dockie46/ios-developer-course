//
//  FirebaseAuthManaging.swift
//  Course App
//
//  Created by Patrik Urban on 13.06.2024.
//
import FirebaseAuth
import Foundation

protocol FirebaseAuthManaging {
    func signUp(_ credentials: Credentials) async throws
    func signIn(_ entity: Credentials) async throws
    func signOut() async throws
}
