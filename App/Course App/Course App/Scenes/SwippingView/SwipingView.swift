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
    
    private let jokesService = JokeService(apiManager: APIManager())
    @State private var jokes: [Joke] = []
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        ForEach(jokes, id: \.self) { joke in
                            SwipingCard(
                                configuration: SwipingCard.Configuration(
                                    title: "Category",
                                    description: joke.text
                                ),
                                swipeStateAction: { action in
                                    // swiftlint:disable:next disable_print
                                    print("swipe action \(action)")
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
            fetchData()
        }
        .navigationTitle("Random jokes")
    }
    
    func fetchData() {
        Task {
            try await withThrowingTaskGroup(of: JokeResponse.self) { group in
                for _ in 1...10 {
                    group.addTask {
                        try await jokesService.fetchRandomJoke()
                    }
                }
                
                for try await jokeResponse in group {
                    jokes.append(Joke(jokeResponse: jokeResponse))
                }
            }
        }
    }
}

#Preview {
    SwipingView()
}
