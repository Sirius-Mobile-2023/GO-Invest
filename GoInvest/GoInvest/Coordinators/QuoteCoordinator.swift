import QuoteDetail
import UIKit
import QuoteClient
import DomainModels

class QuoteCoordinator {
    var navigationController: UINavigationController
    var navigationTitle: String

    init(navigationController: UINavigationController, title: String) {
        self.navigationController = navigationController
        navigationTitle = title
    }

    func start() {
        let client = QuoteClient()
        let detail = client.quoteDetail(id: "ABRD",
                                        boardId: "TQBR",
                                        completion: { result in
            switch result {
            case .success(let quote):
                print("✅")
                print(quote)
            case .failure(let error):
                print("❌")
                print(error)
            }
        })

//        let points = client.quoteCharts(id: "ABRD",
//                                        boardId: "TQBR",
//                                        fromDate: dateFromString(str: "2021-04-14")!,
//                                        completion: { result in
//            switch result {
//            case .success(let quoteCharts):
//                print("✅")
//                print(quoteCharts.points)
//            case .failure(let error):
//                print("❌")
//                print(error)
//            }
//        })
        let viewController = QuoteDetailViewController()
        viewController.navigationItem.title = navigationTitle
        navigationController.pushViewController(viewController, animated: true)
    }
    func dateFromString(str: String?) -> Date? {
        guard let str = str else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        return dateFormatter.date(from: str)
    }
}
