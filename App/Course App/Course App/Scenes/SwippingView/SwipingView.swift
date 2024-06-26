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
    
    private let dataProvider = MockDataProvider()
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    if let jokes = dataProvider.data.first?.jokes {
                        ZStack {
                            ForEach(jokes, id: \.self) { joke in
                                SwipingCard(
                                    configuration: SwipingCard.Configuration(
                                        image: Image(uiImage: joke.image ?? UIImage()),
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
                    } else {
                        Text("Empty data!")
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .defaultBackgroundColor()
        .navigationTitle("Random jokes")
    }
}

#Preview {
    SwipingView()
}
