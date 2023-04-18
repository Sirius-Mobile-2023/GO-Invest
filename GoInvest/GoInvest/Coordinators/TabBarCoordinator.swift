import Profile
import Strategy
import Quotes
import UIKit

class TabBarCoordinator {
    var tabBarController: UITabBarController

    required init(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let quotesVC = QuotesViewController()
        let strategyVC = StrategyViewController()
        let profileVC = ProfileViewController()
        let quotesNC = UINavigationController(rootViewController: quotesVC)
        let strategyNC = UINavigationController(rootViewController: strategyVC)
        let profileNC = UINavigationController(rootViewController: profileVC)

        quotesVC.didTapButton = { title in
            self.showQuoteController(with: title, navigationController: quotesNC)
        }

        quotesNC.tabBarItem = UITabBarItem(title: "Quotes", image: UIImage(systemName: "arrow.up.arrow.down"), tag: 0)
        strategyNC.tabBarItem = UITabBarItem(title: "Strategy", image: UIImage(systemName: "function"), tag: 1)
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        profileNC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        let controllers = [quotesNC, strategyNC, profileNC]
        controllers.forEach { $0.navigationBar.prefersLargeTitles = true }

        prepareTabBarController(withTabControllers: controllers)
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
