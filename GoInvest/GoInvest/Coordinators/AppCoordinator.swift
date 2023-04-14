import UIKit

class AppCoordinator {
    var tabBarController: UITabBarController
    let window: UIWindow

    init(window: UIWindow, tabBarController: UITabBarController) {
        self.window = window

        self.tabBarController = tabBarController
    }

    func start() {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        startFirstVC(tabBarController)
    }

    private func startFirstVC(_: UITabBarController) {
        let firstCoordinator = TabBarCoordinator(tabBarController)
        firstCoordinator.start()
    }
}
