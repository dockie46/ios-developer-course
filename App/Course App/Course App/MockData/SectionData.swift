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

    init(title: String, jokes: [JokeResponse]) {
        self.title = title
        self.jokes = jokes.map { Joke(jokeResponse: $0) }
    }
}

