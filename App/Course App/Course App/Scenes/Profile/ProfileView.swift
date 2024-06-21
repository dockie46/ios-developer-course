//
//  SwiftUIView.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import Combine
import SwiftUI

struct ProfileView: View {
    private let eventSubject = PassthroughSubject<ProfileViewEvent, Never>()
    private let authManager = FirebaseAuthManager(keichain: KeychainService(keychainManager: KeychainManager()))
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
            
            Button("Onboarding") {
                eventSubject.send(.onboarding)
            }
            Button("Onboarding (modal)") {
                eventSubject.send(.onboardingModal)
            }
            Button("Sign out") {
               signOut()
            }
            
            Spacer()

        }
        .navigationTitle("Profile")
    }
}

extension ProfileView: EventEmitting {
    var eventPublisher: AnyPublisher<ProfileViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

private extension ProfileView {
    @MainActor
    func signOut() {
        Task {
            try? await authManager.signOut()
            eventSubject.send(.signOut)
        }
    }
}

#Preview {
    ProfileView()
}
