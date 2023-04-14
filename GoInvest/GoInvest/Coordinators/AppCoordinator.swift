import UIKit

class AppCoordinator {
    let tabBarController: UITabBarController
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
    }

    func start() {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        startFirstVC()
    }

    private func startFirstVC() {
        let firstCoordinator = TabBarCoordinator(tabBarController)
        firstCoordinator.start()
    }
}
