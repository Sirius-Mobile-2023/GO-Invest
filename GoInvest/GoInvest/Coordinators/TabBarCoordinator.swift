import QuoteClient
import Profile
import Strategy
import Quotes
import DomainModels
import Theme
import UIKit
import QuoteListModel

class TabBarCoordinator {
    var tabBarController: UITabBarController
    var childCoordinators = [QuoteCoordinator]()

    required init(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let modelQuoteList = ListQuoteModel(client: QuoteClient())
        let strategyVC = StrategyViewController(modelQuoteList: modelQuoteList)
        let quotesVC = QuotesViewController(modelQuoteList: modelQuoteList)
        let profileVC = ProfileViewController()
        let quotesNC = UINavigationController(rootViewController: quotesVC)
        let strategyNC = UINavigationController(rootViewController: strategyVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        quotesVC.didTapButton = { [weak self] quote in
            self?.showQuoteController(with: quote, navigationController: quotesNC)
        }
        profileVC.didTapButton = { [weak self] quote in
            self?.showQuoteController(with: quote, navigationController: profileNC)
        }
        quotesNC.tabBarItem = UITabBarItem(title: "Quotes", image: Theme.Images.quotesTabBar, tag: 0)
        strategyNC.tabBarItem = UITabBarItem(title: "Strategy", image: Theme.Images.strategyTabBar, tag: 1)
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: Theme.Images.profileTabBarUnchecked, tag: 2)
        profileNC.tabBarItem.selectedImage = Theme.Images.profileTabBarChecked

        let controllers = [quotesNC, strategyNC, profileNC]

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
        childCoordinators.append(quoteCoordinator)
        quoteCoordinator.removeFromMemory = { [weak self] in
            self?.childCoordinators.removeLast()
        }
        quoteCoordinator.start()
    }
}
