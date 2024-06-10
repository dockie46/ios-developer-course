//
//  JokeResponse.swift
//  Course App
//
//  Created by Patrik Urban on 09.06.2024.
//

import Foundation

struct JokeResponse: Codable, Hashable {
    let id: String
    let categories: [String]
    let createdAt: Date
    let url: URL
    let value: String
}
