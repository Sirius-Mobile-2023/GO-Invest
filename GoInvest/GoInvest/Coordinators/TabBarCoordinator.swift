import Profile
import QuoteClient
import Quotes
import DomainModels
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
        profileVC.didTapButton = { [weak self] quote in
            self?.showFavsController(with: quote, navigationController: profileNC)
        }
        quotesNC.tabBarItem = UITabBarItem(title: "Quotes", image: UIImage(systemName: "arrow.up.arrow.down"), tag: 0)
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        profileNC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

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
        print("show quote controller")
        let quoteCoordinator = QuoteCoordinator(navigationController: navigationController, quote: quote)
        quoteCoordinator.start()
    }

    func showFavsController(with quote: Quote, navigationController: UINavigationController) {
        let quoteCoordinator = FavoritesCoordinator(navigationController: navigationController, quote: quote)
        quoteCoordinator.start()
    }
}
