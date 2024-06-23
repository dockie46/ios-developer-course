//
//  MockKeyChainManager.swift
//  Course Tests
//
//  Created by Work on 23.06.2024.
//

import Foundation

final class MockKeychainManager: KeychainManaging {
    
    private var storage = [String: Data]()
    private let encoder = JSONEncoder()
    
    func store(key: String, value: some Encodable) throws {
        let data = try encoder.encode(value)
        storage[key] = data
    }

    func fetch<T>(key: String) throws -> T where T: Decodable {
        guard let data = storage[key] else {
            throw NSError(domain: "MockKeychainManagerError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Key not found"])
        }
        let decoder = JSONDecoder()
        let value = try decoder.decode(T.self, from: data)
        return value
    }

    func remove(key: String) throws {
        storage.removeValue(forKey: key)
    }
}

extension MockKeychainManager {
    static let key_username = "app.email"
    static let key_password = "app.password"
}
