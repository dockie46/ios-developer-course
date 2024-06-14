//
//  SwipingCard.swift
//  Course App
//
//  Created by Patrik Urban on 19.05.2024.
//

import SwiftUI

struct SwipingCard: View {
    private enum UIConstant {
        static let cardRadius: CGFloat = 15
        static let cardHeightOffset: CGFloat = 0.5
        static let cardRotationEffect: CGFloat = 40
        static let colorOpacity: CGFloat = 0.7
        static let cardDescriptionPadding: CGFloat = 10
        static let cardDescriptionColorOpacity: CGFloat = 0.5
        static let cardDescriptionRadius: CGFloat = 10
        static let finishSwipeIntervalMin: CGFloat = 200
        static let finishSwipeIntervalMax: CGFloat = 500
        static let finishSwipeHeight: CGFloat = 0
        static let swipeColorOpacity: CGFloat = 0.7
        static let swipeColoredOpacity: CGFloat = 0.6
        static let swipeIntervalMinToReact: CGFloat = 60
    }
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
        let title: String
        let description: String
    }

    // MARK: Private variables
    private let swipingAction: Action<SwipeState>
    private let configuration: Configuration
    @State private var offset: CGSize = .zero
    @State private var color: Color = .bg.opacity(UIConstant.colorOpacity)
    init(
        configuration: Configuration,
        swipeStateAction: @escaping (Action<SwipeState>)
    ) {
        self.configuration = configuration
        self.swipingAction = swipeStateAction
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                ScratchView(
                    text: configuration.description
                )
                Spacer()
                cardDescription
            }
            Spacer()
        }
        .background(color)
        .cornerRadius(UIConstant.cardRadius)
        .offset(x: offset.width, y: offset.height * UIConstant.cardHeightOffset)
        .rotationEffect(.degrees(Double(offset.width / UIConstant.cardRotationEffect)))
        .gesture(dragGesture)
    }
    
    private var cardDescription: some View {
        Text(configuration.title)
            .textTypeModifier(textType: .normal)
            .padding(UIConstant.cardDescriptionPadding)
            .background(Color.black.opacity(UIConstant.cardDescriptionColorOpacity))
            .cornerRadius(UIConstant.cardDescriptionRadius)
            .padding()
    }
    
    // MARK: Drag gesture
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                withAnimation {
                    swiping(translation: offset)
                }
            }
            .onEnded { _ in
                withAnimation {
                    finishSwipe(translation: offset)
                }
            }
    }
}

// MARK: - Swipe logic
private extension SwipingCard {
    func finishSwipe(translation: CGSize) {
        // swipe left
        if -1 * UIConstant.finishSwipeIntervalMax...(-1 * UIConstant.finishSwipeIntervalMin) ~= translation.width {
            offset = CGSize(width: -1 * UIConstant.finishSwipeIntervalMax, height: 0)
            swipingAction(.finished(direction: .left))
        } else if UIConstant.finishSwipeIntervalMin...UIConstant.finishSwipeIntervalMax ~= translation.width { // swipe right
            offset = CGSize(width: UIConstant.finishSwipeIntervalMax, height: 0)
            swipingAction(.finished(direction: .right))
        } else {
            // re-center
            offset = .zero
            color = .bg.opacity(UIConstant.swipeColorOpacity)
            swipingAction(.cancelled)
        }
    }
    
    func swiping(translation: CGSize) {
        // swipe left
        if translation.width < -1 * UIConstant.swipeIntervalMinToReact {
            color = .green
                .opacity(Double(abs(translation.width) / UIConstant.finishSwipeIntervalMax) + UIConstant.swipeColoredOpacity)
            swipingAction(.swiping(direction: .left))
        } else if translation.width > UIConstant.swipeIntervalMinToReact {
            // swipe right
            color = .red
                .opacity(Double(translation.width / UIConstant.finishSwipeIntervalMax) + UIConstant.swipeColoredOpacity)
            swipingAction(.swiping(direction: .right))
        } else {
            color = .bg.opacity(UIConstant.swipeColorOpacity)
            swipingAction(.cancelled)
        }
    }
}


struct Card_Previews: PreviewProvider {
    static let width: CGFloat = 220
    static let height: CGFloat = 340
    static var previews: some View {
        SwipingCard(
            configuration: SwipingCard.Configuration(
                title: "Card Title",
                description: "This is a short description. This is a short description. This is a short description. This is a short description. This is a short description."
            ),
            swipeStateAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .frame(width: width, height: height)
    }
}
