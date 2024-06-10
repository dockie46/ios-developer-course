//
//  MockDataProvider.swift
//  Course App
//
//  Created by Patrik Urban on 11.05.2024.
//

import Foundation
import UIKit

struct Joke: Identifiable, Hashable {
    let id: String
    let text: String
    let categories: [String]
    
    init(jokeResponse: JokeResponse) {
        self.id = jokeResponse.id
        self.text = jokeResponse.value
        self.categories = jokeResponse.categories
    }
}
