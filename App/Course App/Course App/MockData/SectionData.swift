//
//  SectionData.swift
//  Course App
//
//  Created by Patrik Urban on 10.06.2024.
//

import Foundation

struct SectionData: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var jokes: [Joke]

    init(title: String, jokes: [JokeResponse], likes: [String: Bool]) {
        self.title = title
        self.jokes = jokes.map {
            print("\($0.id) : \(likes[$0.id])")
            return Joke(jokeResponse: $0, liked: likes[$0.id] ?? false)
        }
    }
}

