//
//  KeychainManagerError.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation
import KeychainAccess
enum KeychainManagerError: LocalizedError {
    /// Couldn't find data under specified key.
    case dataNotFound

    var errorDescription: String? {
        switch self {
        case .dataNotFound:
            "Data for key not found"
        }
    }
}
