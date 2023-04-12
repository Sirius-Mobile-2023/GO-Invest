//
//  TabBarCoordinator.swift
//  GoInvest
//
//  Created by Анастасия Бегинина on 11.04.2023.
//

import UIKit
import Quotes
import Profile

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var tabBarController: UITabBarController

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let quotes = QuotesViewController()
        let profile = ProfileViewController()
        quotes.didTapButton = { title in
            self.showQuoteController(with: title)
        }

        let nav1 = UINavigationController(rootViewController: quotes)
        let nav2 = UINavigationController(rootViewController: profile)

        nav1.tabBarItem = UITabBarItem(title: "Quotes", image: UIImage(systemName: "arrow.up.arrow.down"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        let controllers = [nav1, nav2]
        prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        navigationController.viewControllers = [tabBarController]
        tabBarController.setViewControllers(tabControllers, animated: true)
    }

    func showQuoteController(with quote: String) {
        print("Show quote")
        let quoteCoordinator = QuoteCoordinator(navigationController: navigationController, title: quote)
        quoteCoordinator.start()
    }
}
