import UIKit
import SkeletonView

class AppCoordinator {
    var navigationController: UINavigationController
    let window: UIWindow

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
