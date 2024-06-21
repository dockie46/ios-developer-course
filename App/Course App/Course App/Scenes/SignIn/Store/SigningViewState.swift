//
//  SigningViewState.swift
//  Course App
//
//  Created by Patrik Urban on 21.06.2024.
//

import Foundation

struct SigningViewState {
    enum Status {
        case initial
        case ready
    }
    var email: String = ""
    var password: String = ""
    var status: Status = .initial

    static let initial = SigningViewState()
}
