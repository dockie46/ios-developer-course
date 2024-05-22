//
//  MainTabBarController.swift
//  Course App
//
//  Created by Work on 21.05.2024.
//

import Foundation
import SwiftUI
import UIKit

struct MainTabView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainTabBarController {
        MainTabBarController()
    }
    
    func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {}
}

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGlobalTabBarUI()
        setupTabBarControllers()
    }
}

// MARK: UI Setup
private extension MainTabBarController {
    func setupTabBar() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    
    func setupGlobalTabBarUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    func setupTabBarControllers() {
        viewControllers = [setupCategoriesView(), setupSwipingCardView()]
    }
    
    func setupCategoriesView() -> UIViewController {
        UINavigationController().forTabBarItemViewPage(UIHostingController(rootView: HomeView()), title: "Categories", tabBarItemImageSystemName: "list.dash.header.rectangle", tag: 1)
    }
    
    func setupSwipingCardView() -> UIViewController {
        UINavigationController().forTabBarItemViewPage(UIHostingController(rootView: SwipingView()), title: "Random", tabBarItemImageSystemName: "switch.2", tag: 1)
    }
}


extension UINavigationController {
    func forTabBarItemViewPage(_ rootViewController: UIViewController, title: String, tabBarItemImageSystemName: String, tag: Int) -> UIViewController {
        let textType = TextType.navbarTitle
        
        rootViewController.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: tabBarItemImageSystemName), tag: tag)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .brown
        appearance.titleTextAttributes = [.font: textType.uiFont, .foregroundColor: UIColor(textType.color)]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        return navigationController
    }
}
