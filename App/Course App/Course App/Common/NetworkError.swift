//
//  NetworkError.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation

enum NetworkError: Error {
    
    case networkError(message: String)
    case unknownError

        var localizedDescription: String {
            switch self {
            case .networkError(let message):
                return "Network Error occured: \(message)"
            case .unknownError:
                return "Unknown error occurred."
            }
        }
}
