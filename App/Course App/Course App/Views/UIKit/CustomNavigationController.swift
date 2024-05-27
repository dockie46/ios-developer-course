//
//  CustomNavigationController.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
    }
}

extension UINavigationController {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .brown
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: TextType.navbarTitle.uiFont,
            NSAttributedString.Key.foregroundColor: UIColor(TextType.navbarTitle.color)
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
