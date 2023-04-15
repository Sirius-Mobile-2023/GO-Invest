import Profile
import Quotes
import Theme
import UIKit

class TabBarCoordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        tabBarController = .init()
    }

    func start() {
        let quotes = QuotesViewController()
        let profile = ProfileViewController()
        quotes.didTapButton = { title in
            self.showQuoteController(with: title)
        }

        let nav1 = UINavigationController(rootViewController: quotes)
        let nav2 = UINavigationController(rootViewController: profile)

        nav1.tabBarItem = UITabBarItem(title: "Quotes", image: Theme.quotesTabBarImage, tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: Theme.profileTabBarImageUnchecked, tag: 1)
        nav2.tabBarItem.selectedImage = Theme.profileTabBarImageChecked
        let controllers = [nav1, nav2]
        styleNavigationController()
        prepareTabBarController(withTabControllers: controllers)
    }

    private func styleNavigationController() {
        navigationController.navigationBar.backIndicatorImage = Theme.backNavBarImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = Theme.backNavBarImage
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
