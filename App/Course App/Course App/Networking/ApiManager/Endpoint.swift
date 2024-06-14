//
//  Endpoint.swift
//  Course App
//
//  Created by Patrik Urban on 09.06.2024.
//

import Foundation

protocol Endpoint {
    var host: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [String: String] { get }

    func asURLRequest() throws -> URLRequest
}
