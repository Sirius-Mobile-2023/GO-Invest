import QuoteClient
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

        quotesVC.didTapButton = { [weak self] title in
            self?.showQuoteController(with: title, navigationController: quotesNC)
        }
        quotesVC.client = QuoteClient()

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

    func showQuoteController(with quote: String, navigationController: UINavigationController) {
        let quoteCoordinator = QuoteCoordinator(navigationController: navigationController, title: quote)
        quoteCoordinator.start()
    }
}
