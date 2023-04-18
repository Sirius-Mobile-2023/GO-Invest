import DomainModels
import QuoteClient
import QuoteDetail
import UIKit

class QuoteCoordinator {
    var navigationController: UINavigationController
    var navigationTitle: String
    var selectedQuote: Quote

    init(navigationController: UINavigationController, quote: Quote) {
        self.navigationController = navigationController
        navigationTitle = quote.name
        selectedQuote = quote
    }

    func start() {
        let client = QuoteClient()
        let viewController = QuoteDetailViewController()
        viewController.quote = selectedQuote
        viewController.navigationItem.title = navigationTitle
        navigationController.pushViewController(viewController, animated: true)
    }
}
