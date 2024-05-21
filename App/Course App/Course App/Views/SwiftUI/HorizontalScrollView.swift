//
//  HorizontalScrollView.swift
//  Course App
//
//  Created by Work on 22.05.2024.
//

import SwiftUI

struct HorizontalScrollView: View {
    
    let data: [Joke]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(data) { joke in
                    Image(uiImage: joke.image ?? UIImage())
                        .resizableBordered(cornerRadius: 10)
                        .onTapGesture {
                            print("Tapped joke \(joke)")
                        }
                }
            }
        }.defaultBackgroundColor()
    }
}

#Preview {
    HorizontalScrollView(data: [])
}
