//
//  SwipingCard.swift
//  Course App
//
//  Created by Patrik Urban on 19.05.2024.
//

import SwiftUI

typealias Action<T> = (T) -> Void
struct SwipingCard: View {
    
    enum SwipeDirection {
        case left
        case right
    }
    
    // MARK: - SwipeState
    enum SwipeState {
        case swiping(direction: SwipeDirection)
        case finished(direction: SwipeDirection)
        case cancelled
    }
    
    // MARK: - Configuration
    struct Configuration: Equatable {
        let image: Image
        let title: String
        let description: String
    }
    
    private let swipingAction: Action<SwipeState>
    private let configuration: Configuration
    
    init(
        configuration: Configuration,
        swipeStateAction: @escaping (Action<SwipeState>)
    ) {
        self.configuration = configuration
        self.swipingAction = swipeStateAction
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    private var cardDescription: some View {
        Text(configuration.title)
            .textTypeModifier(textType: .h1Title)
            .padding(10)
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .padding()
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        SwipingCard(
            configuration: SwipingCard.Configuration(
                image: Image("nature"),
                title: "Card Title",
                description: "This is a short description. This is a short description. This is a short description. This is a short description. This is a short description."
            ),
            swipeStateAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .frame(width: 220, height: 340)
    }
}
