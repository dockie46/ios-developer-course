//
//  OnboardingView.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import SwiftUI

struct OnboardingViewStart: View {
    var coordinator: OnboardingCoordinating?
    private enum Constant {
        static let nextPage: Int = 2
    }
    var body: some View {
        VStack {
            Text("Welcome page")
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
    OnboardingViewStart(coordinator: OnboardingNavigationCoordinator(initialPage: 1))
}
