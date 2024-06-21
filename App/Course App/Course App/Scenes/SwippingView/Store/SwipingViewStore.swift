//
//  SwipingViewStore.swift
//  Course App
//
//  Created by Patrik Urban on 21.06.2024.
//

import Combine
import Foundation
import os

final class SwipingViewStore: ObservableObject, EventEmitting, Store {
    private let store: StoreManaging
    private let kechainService: KeychainServicing
    private let jokesService: JokeServicing
    private var category: String?
    private let logger = Logger()
    private var counter: Int = 0
    private let eventSubject = PassthroughSubject<SwipingViewEvent, Never>()
    @Published var state: SwipingViewState = .initial

    init(store: StoreManaging, keychainService: KeychainServicing, jokeService: JokeServicing) {
        self.kechainService = keychainService
        self.store = store
        self.jokesService = jokeService
    }

    var eventPublisher: AnyPublisher<SwipingViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension SwipingViewStore {
    @MainActor
    func send(_ action: SwipingViewAction) {
        switch action {
        case let .dataFetched(jokes):
            logger.info("thread \(Thread.current.description)")
            state.jokes.append(contentsOf: jokes)
            state.status = .ready
        case .viewDidLoad:
            logger.info("thread \(Thread.current.description)")
            state.status = .loading
            fetchRandomJokes()
        case let .didLike(jokeId, liked):
            storeJokeLike(jokeId: jokeId, liked: liked)
            counter += 1
            if counter == state.jokes.count {
                send(.noMoreJokes)
            }
        case .noMoreJokes:
            eventSubject.send(.dismiss)
        }
    }
}

private extension SwipingViewStore {
    func fetchRandomJokes() {
        Task {
            logger.info("thread \(Thread.current.description)")
            try await withThrowingTaskGroup(of: JokeResponse.self) { [weak self] group in
                guard let self else {
                    return
                }
                for _ in 1...5 {
                    group.addTask {
                        if let category = self.category {
                            try await self.jokesService.fetchJokeForCategory(category)
                        } else {
                            try await self.jokesService.fetchRandomJoke()
                        }
                    }
                }

                var jokes: [Joke] = []
                for try await jokeResponse in group {
                    jokes.append(Joke(jokeResponse: jokeResponse, liked: false))
                }
                logger.info("thread \(Thread.current.description)")
                await send(.dataFetched(jokes))
            }
        }
    }

    func storeJokeLike(jokeId: String, liked: Bool) {
        Task {
            try await self.store.storeLike(jokeId: jokeId, liked: liked)
        }
    }
}
