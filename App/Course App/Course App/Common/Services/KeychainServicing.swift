//
//  KeychainServicing.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation

protocol KeychainServicing {
    var keychainManager: KeychainManaging { get }
    func storeAuthData(authData: String) throws
}
