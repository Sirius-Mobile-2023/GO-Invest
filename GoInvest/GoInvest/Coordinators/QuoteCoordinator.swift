import QuoteDetail
import UIKit
import ListClient

class QuoteCoordinator {
    var navigationController: UINavigationController
    var navigationTitle: String

    init(navigationController: UINavigationController, title: String) {
        self.navigationController = navigationController
        navigationTitle = title
    }

    func start() {
        let viewController = QuoteDetailViewController()
        viewController.navigationItem.title = navigationTitle
        navigationController.pushViewController(viewController, animated: true)
        
        let quoteListClient = QuoteListClient()
        let result = quoteListClient.quoteList(search: .listDefault, completion: {_ in return})
    }
}
