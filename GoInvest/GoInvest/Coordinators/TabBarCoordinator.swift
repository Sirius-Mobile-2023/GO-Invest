import QuoteClient
import DomainModels
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
        let quotesVC = QuotesViewController(client: QuoteClient())
        let profileVC = ProfileViewController()
        let quotesNC = UINavigationController(rootViewController: quotesVC)
        let profileNC = UINavigationController(rootViewController: profileVC)

        quotesVC.didTapButton = { [weak self] quote in
            self?.showQuoteController(with: quote, navigationController: quotesNC)
        }
        
        quotesNC.tabBarItem = UITabBarItem(title: "Quotes", image: Theme.Images.quotesTabBar, tag: 0)
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: Theme.Images.profileTabBarUnchecked, tag: 2)
        profileNC.tabBarItem.selectedImage = Theme.Images.profileTabBarChecked
        
        let controllers = [quotesNC, profileNC]
        controllers.forEach { $0.navigationBar.prefersLargeTitles = true }

        prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.setViewControllers(tabControllers, animated: true)
    }

    func showQuoteController(with quote: Quote, navigationController: UINavigationController) {
        let quoteCoordinator = QuoteCoordinator(navigationController: navigationController, quote: quote)
        quoteCoordinator.start()
    }
}
