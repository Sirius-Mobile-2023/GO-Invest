import Profile
import Quotes
import Theme
import UIKit

class TabBarCoordinator {
    var tabBarController: UITabBarController

    required init(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let quotesVC = QuotesViewController()
        let profileVC = ProfileViewController()
        let quotesNC = UINavigationController(rootViewController: quotesVC)
        let profileNC = UINavigationController(rootViewController: profileVC)

        quotesVC.didTapButton = { title in
            self.showQuoteController(with: title, navigationController: quotesNC)
        }

        let nav1 = UINavigationController(rootViewController: quotes)
        let nav2 = UINavigationController(rootViewController: profile)

        let controllers = [quotesNC, profileNC]
        controllers.forEach { $0.navigationBar.prefersLargeTitles = true }

        prepareTabBarController(withTabControllers: controllers)
    }

    private func styleNavigationController() {
        navigationController.navigationBar.backIndicatorImage = Theme.Images.backNavBar
        navigationController.navigationBar.backIndicatorTransitionMaskImage = Theme.Images.backNavBar
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.setViewControllers(tabControllers, animated: true)
    }

    func showQuoteController(with quote: String, navigationController: UINavigationController) {
        let quoteCoordinator = QuoteCoordinator(navigationController: navigationController, title: quote)
        quoteCoordinator.start()
    }
}
