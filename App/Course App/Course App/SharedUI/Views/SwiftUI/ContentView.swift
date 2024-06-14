//
//  ContentView.swift
//  Course App
//
//  Created by Patrik Urban on 10.05.2024.
//

import os
import SwiftUI

struct ContentView: View {
    private let logger = Logger()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            logger.trace("Contentview on appear method")
        }
    }
}

#Preview {
    ContentView()
}
