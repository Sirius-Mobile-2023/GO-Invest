import QuoteClient
import Profile
import Strategy
import Quotes
import DomainModels
import Theme
import UIKit
import QuoteListModel
import Login
import AppState
import FirebaseAuth

class TabBarCoordinator {
    var tabBarController: UITabBarController
    var childCoordinators = [QuoteCoordinator]()
    let profileVC = ProfileViewController(client: QuoteClient())

    required init(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let modelQuoteList = ListQuoteModel(client: QuoteClient())
        let strategyVC = StrategyViewController(modelQuoteList: modelQuoteList)
        let quotesVC = QuotesViewController(modelQuoteList: modelQuoteList)

        let quotesNC = UINavigationController(rootViewController: quotesVC)
        let strategyNC = UINavigationController(rootViewController: strategyVC)
        let profileNC = UINavigationController(rootViewController: profileVC)
        quotesVC.didTapButton = { [weak self] quote in
            self?.showQuoteController(with: quote, navigationController: quotesNC)
        }
        let loginVC = LoginViewController()
        let regVC = RegistrationViewController()
        if let curUser = Auth.auth().currentUser {
            profileVC.refreshVC(with: curUser.email!)
            AppState.isAuth = true
            profileVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(didTapSignOut))
            profileVC.navigationItem.rightBarButtonItem?.tintColor = Theme.Colors.mainText
        }

        profileVC.toLogin = {
            loginVC.modalPresentationStyle = .popover
            loginVC.loginButtonHandler = { [weak self] email, password in
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                    if authResult != nil {
                        loginVC.dismiss(animated: true)
                        AppState.isAuth = true
                        self?.profileVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(self?.didTapSignOut))
                        self?.profileVC.navigationItem.rightBarButtonItem?.tintColor = Theme.Colors.mainText
                        self?.profileVC.refreshVC(with: email)
                        // call data from firebase
                    } else {
                        loginVC.wrongDataAnimate()
                    }
                    print(error)
                }
            }
            self.profileVC.present(loginVC, animated: true, completion: nil)
        }

        profileVC.toReg = {
            regVC.modalPresentationStyle = .popover
            regVC.regButtonHandler = { [weak self] email, password in
                Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                    if authResult != nil {
                        regVC.dismiss(animated: true)
                        AppState.isAuth = true
                        self?.profileVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(self?.didTapSignOut))
                        self?.profileVC.navigationItem.rightBarButtonItem?.tintColor = Theme.Colors.mainText
                        self?.profileVC.refreshVC(with: email)
                    } else {
                        regVC.wrongDataAnimate()
                    }
                    print(error)
                }
            }
            self.profileVC.present(regVC, animated: true, completion: nil)
        }

        profileVC.didTapButton = { [weak self] quote in
            self?.showQuoteController(with: quote, navigationController: profileNC)
        }
        quotesNC.tabBarItem = UITabBarItem(title: "Quotes", image: Theme.Images.quotesTabBar, tag: 0)
        strategyNC.tabBarItem = UITabBarItem(title: "Strategy", image: Theme.Images.strategyTabBar, tag: 1)
        profileNC.tabBarItem = UITabBarItem(title: "Favorites", image: Theme.Images.profileTabBarUnchecked, tag: 2)
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

    @objc private func didTapSignOut() throws {
        try! Auth.auth().signOut()
        AppState.isAuth = false
        profileVC.refreshVC(with: "")
    }
}
