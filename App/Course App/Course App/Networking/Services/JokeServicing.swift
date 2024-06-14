//
//  JokeServicing.swift
//  Course App
//
//  Created by Patrik Urban on 09.06.2024.
//

import Foundation

protocol JokeServicing {
    var apiManager: APIManaging { get }

    func fetchCategories() async throws -> [String]
    func fetchRandomJoke() async throws -> JokeResponse
    func fetchJokeForCategory(_ category: String) async throws -> JokeResponse
}
