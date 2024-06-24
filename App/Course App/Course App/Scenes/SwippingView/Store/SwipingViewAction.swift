//
//  SwipingViewAction.swift
//  Course App
//
//  Created by Patrik Urban on 21.06.2024.
//

import Foundation

enum SwipingViewAction {
    case viewDidLoad
    case dataFetched([Joke])
    case didLike(String, Bool)
    case noMoreJokes
}
