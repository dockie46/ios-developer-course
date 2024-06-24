//
//  NetworkError.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation

enum NetworkError: Error {
    
    case invalidUrlComponents
    case noHttpResponse
    case unacceptableStatusCode
    case decodingFailed(error: Error)
}
