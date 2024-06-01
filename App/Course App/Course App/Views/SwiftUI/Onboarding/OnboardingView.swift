//
//  OnboardingView.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//
import Combine
import SwiftUI

enum OnboardingViewEvent {
    case nextPage(from: Int)
    case close
}

struct OnboardingView: View {
    private let eventSubject = PassthroughSubject<OnboardingViewEvent, Never>()
    let page: Int
    let title: String
    let last: Bool
    var body: some View {
        VStack {
            Text(title)
            if last {
                Button(action: {
                    eventSubject.send(.close)
                }) {
                    Text("Close")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Button(action: {
                    eventSubject.send(.nextPage(from: page))
                }) {
                    Text("Next")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

        }.navigationTitle(title)
    }
}

// MARK: - Event emitter
extension OnboardingView: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

#Preview {
    OnboardingView(page: 1, title: "test", last: false)
}
