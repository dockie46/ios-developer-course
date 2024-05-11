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
    private let isUIKit = true
    var body: some View {
        homeView
        .onAppear {
            logger.trace("ContentView on appear method")
        }
    }
    
    @ViewBuilder
    var homeView: some View {
        if isUIKit {
            HomeView()
        } else {
            
        }
    }
}

#Preview {
    ContentView()
}
