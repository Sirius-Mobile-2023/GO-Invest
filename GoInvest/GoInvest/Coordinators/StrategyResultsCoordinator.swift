import DomainModels
import QuoteClient
import QuoteDetail
import UIKit

class StrategyResultsCoordinator {
    private var navigationController: UINavigationController
    private var selectedQuote: Quote
    var removeFromMemory: (() -> Void)?
    var childCoordinators = [QuoteCoordinator]()

    init(navigationController: UINavigationController, quote: Quote) {
        self.navigationController = navigationController
        selectedQuote = quote
    }

    func start() {
        print("started")
        let quoteCoordinator = QuoteCoordinator(navigationController: navigationController, quote: selectedQuote)
        childCoordinators.append(quoteCoordinator)
        quoteCoordinator.removeFromMemory = { [weak self] in
            self?.childCoordinators.removeLast()
        }
        quoteCoordinator.start()
    }

}
