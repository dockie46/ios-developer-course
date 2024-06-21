//
//  SwipingView.swift
//  Course App
//
//  Created by Patrik Urban on 19.05.2024.
//
import Combine
import SwiftUI

struct SwipingView: View {
    
    private enum UIConstant {
        static let paddingHeight: CGFloat = 20
        static let frameDimensionDivider: CGFloat = 1.2
        static let frameDimensionMultiplier: CGFloat = 1.5
    }
    
    // MARK: Private variables
    @StateObject private var store: SwipingViewStore
    
    init(store: SwipingViewStore) {
        _store = .init(wrappedValue: store)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        ForEach(store.state.jokes, id: \.self) { joke in
                            SwipingCard(
                                configuration: SwipingCard.Configuration(
                                    title: joke.categories.first ?? "Category",
                                    description: joke.text
                                ),
                                swipeStateAction: { action in
                                    switch action {
                                    case let .finished(direction):
                                        store.send(.didLike(joke.id, direction == .left))
                                    default:
                                        break
                                    }
                                }
                            )
                        }
                    }
                    .padding(.top, geometry.size.height / UIConstant.paddingHeight)
                    .frame(width: geometry.size.width / UIConstant.frameDimensionDivider, height: (geometry.size.width / UIConstant.frameDimensionDivider) * UIConstant.frameDimensionMultiplier)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .defaultBackgroundColor()
        .onFirstAppear {
            store.send(.viewDidLoad)
        }
        .navigationTitle("Random jokes")
    }
}
