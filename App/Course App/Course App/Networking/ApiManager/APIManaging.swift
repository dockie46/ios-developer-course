//
//  APIManaging.swift
//  Course App
//
//  Created by Patrik Urban on 09.06.2024.
//

import Foundation

protocol APIManaging {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
