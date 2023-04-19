import DomainModels
import QuoteClient
import QuoteDetail
import UIKit

class QuoteCoordinator {
    var navigationController: UINavigationController
    var navigationTitle: String
    var selectedQuote: Quote
    var removeFromMemory: (() -> Void)?

    init(navigationController: UINavigationController, quote: Quote) {
        self.navigationController = navigationController
        navigationTitle = quote.name
        selectedQuote = quote
    }

    func start() {
        let viewController = QuoteDetailViewController()
        viewController.onViewDidDisappear = { [weak self] in
            self?.removeFromMemory?()
        }
        viewController.quote = selectedQuote
        viewController.navigationItem.title = navigationTitle
        navigationController.pushViewController(viewController, animated: true)
    }

    deinit {
        print("deinit")
    }
}
