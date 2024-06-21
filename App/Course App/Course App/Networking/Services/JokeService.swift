//
//  JokeService.swift
//  Course App
//
//  Created by Patrik Urban on 09.06.2024.
//

import Foundation

final class JokeService: JokeServicing {
    let apiManager: APIManaging

    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
}

// MARK: - Functions
extension JokeService {
    func fetchRandomJoke() async throws -> JokeResponse {
        try await apiManager.request(JokesRouter.getRandomJoke)
    }

    func fetchJokeForCategory(_ category: String) async throws -> JokeResponse {
        try await apiManager.request(JokesRouter.getJokeFor(category: category))
    }

    func fetchCategories() async throws -> [String] {
        try await apiManager.request(JokesRouter.getJokeCategories)
    }
}
