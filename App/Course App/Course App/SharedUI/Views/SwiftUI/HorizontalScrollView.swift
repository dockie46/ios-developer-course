//
//  HorizontalScrollView.swift
//  Course App
//
//  Created by Work on 22.05.2024.
//
import os
import SwiftUI

struct HorizontalScrollView: View {
    private enum UIConstant {
        static let radius: CGFloat = 10
    }

    let logger = Logger()
    let data: [Joke]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(data) { joke in
                    Image(uiImage: joke.image ?? UIImage())
                        .resizableBordered(cornerRadius: UIConstant.radius)
                        .onTapGesture {
                            logger.log("Tap on cell")
                        }
                }
            }
        }.defaultBackgroundColor()
    }
}

#Preview {
    HorizontalScrollView(data: [])
}
