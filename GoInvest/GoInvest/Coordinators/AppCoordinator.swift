import UIKit
import SkeletonView
import StrategiesCount

class AppCoordinator {
    let tabBarController: UITabBarController
    var tabBarCoordinator: TabBarCoordinator?
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
        tabBarCoordinator = TabBarCoordinator(tabBarController)
        tabBarCoordinator?.start()
    }
}
