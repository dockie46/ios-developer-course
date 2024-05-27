//
//  ProfileNavigationCoordinator.swift
//  Course App
//
//  Created by Patrik Urban on 27.05.2024.
//

import Foundation
import UIKit
import SwiftUI

final class ProfileNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    var childCoordinators: [any Coordinator] = [Coordinator]()
    func start() {
        navigationController.setViewControllers([makeProfileCard()], animated: false)
    }
}

private extension ProfileNavigationCoordinator {
    func makeProfileCard() -> UIViewController {
        UIHostingController(rootView: ProfileView())
    }
}
