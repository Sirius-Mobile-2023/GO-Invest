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
        // TODO: #<26 issue, использовать эти примеры в контроллере>
        let client = QuoteClient()
        let detail = client.quoteDetail(id: "ABRD",
                                        boardId: "TQBR",
                                        completion: { result in
                                            switch result {
                                            case let .success(quote):
                                                print("✅")
                                                print(quote)
                                            case let .failure(error):
                                                print("❌")
                                                print(error)
                                            }
                                        })

        let points = client.quoteCharts(id: "ABRD",
                                        boardId: "TQBR",
                                        fromDate: dateFromString(str: "2021-04-14")!,
                                        completion: { result in
                                            switch result {
                                            case let .success(quoteCharts):
                                                print("✅")
                                                print(quoteCharts.points)
                                            case let .failure(error):
                                                print("❌")
                                                print(error)
                                            }
                                        })
        let viewController = QuoteDetailViewController()
        viewController.quote = selectedQuote
        viewController.navigationItem.title = navigationTitle
        navigationController.pushViewController(viewController, animated: true)
    }
    // TODO: #<26 issue, функция как пример для конвертации данных>
    func dateFromString(str: String?) -> Date? {
        guard let str = str else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        return dateFormatter.date(from: str)
    }
}
