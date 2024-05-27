//
//  OnboardingViewSecond.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import SwiftUI

struct OnboardingViewSecond: View {
    var coordinator: OnboardingCoordinating?
    private enum Constant {
        static let nextPage: Int = 3
    }
    var body: some View {
        VStack {
            Text("Second page")
            Button(action: {
                coordinator?.navigateToOnboardingView(page: Constant.nextPage)
            }) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    OnboardingViewSecond()
}
