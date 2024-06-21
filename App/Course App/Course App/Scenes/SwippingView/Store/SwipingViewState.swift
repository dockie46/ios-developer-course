//
//  SwipingViewState.swift
//  Course App
//
//  Created by Patrik Urban on 21.06.2024.
//

import Foundation

struct SwipingViewState {
    enum Status {
        case initial
        case loading
        case ready
    }
    var jokes: [Joke] = []
    var status: Status = .initial

    static let initial = SwipingViewState()
}
