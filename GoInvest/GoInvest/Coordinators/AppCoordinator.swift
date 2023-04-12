//
//  AppCoordinator.swift
//  GoInvest
//
//  Created by Анастасия Бегинина on 11.04.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    let window: UIWindow
    var childCoordinators = [Coordinator]()

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        startFirstVC(navigationController)
    }

    fileprivate func startFirstVC(_ navigationController: UINavigationController) {
        let firstCoordinator = TabBarCoordinator(navigationController)
        firstCoordinator.start()
    }
}
