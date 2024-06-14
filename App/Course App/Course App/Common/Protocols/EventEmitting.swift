//
//  EventEmitting.swift
//  Course App
//
//  Created by Work on 27.05.2024.
//
import Combine
import Foundation

protocol EventEmitting {
    associatedtype Event

    var eventPublisher: AnyPublisher<Event, Never> { get }
}
