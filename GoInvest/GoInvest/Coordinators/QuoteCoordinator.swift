//
//  QuoteCoordinator.swift
//  GoInvest
//
//  Created by Анастасия Бегинина on 11.04.2023.
//

import UIKit

class QuoteCoordinator: Coordinator {
    var navigationController: UINavigationController
    var navigationTitle: String
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController, title: String) {
        self.navigationController = navigationController
        self.navigationTitle = title
    }

    func start() {
        let viewController = QuoteDetailViewController()
        viewController.coordinator = self
        viewController.navigationItem.title = navigationTitle
        navigationController.pushViewController(viewController, animated: true)
    }
}
