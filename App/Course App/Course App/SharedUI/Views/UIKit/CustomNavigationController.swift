//
//  CustomNavigationController.swift
//  Course App
//
//  Created by Patrik Urban on 26.05.2024.
//

import Combine
import Foundation
import UIKit

enum CustomNavigationControllerEvent {
    case dismiss
    case swipeBack
}
class CustomNavigationController: UINavigationController {
    
    private let eventSubject = PassthroughSubject<CustomNavigationControllerEvent, Never>()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            eventSubject.send(.dismiss)
        }
    }
}
// MARK:
extension CustomNavigationController: EventEmitting {
    var eventPublisher: AnyPublisher<CustomNavigationControllerEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension CustomNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("herere??")
        // add custom logic while swiping to dismiss
        return true
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated _: Bool
    ) {
        if viewController == viewControllers.last {
            print("swipe back???")
            eventSubject.send(.swipeBack)
        }
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
