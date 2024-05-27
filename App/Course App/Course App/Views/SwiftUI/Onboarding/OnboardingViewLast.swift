//
//  OnboardingViewLast.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import SwiftUI

struct OnboardingViewLast: View {
    var coordinator: OnboardingCoordinating?
    var body: some View {
        VStack {
            Text("Final page")
            Button(action: {
                coordinator?.finishOnboarding()
            }) {
                Text("Finish")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    OnboardingViewLast()
}
