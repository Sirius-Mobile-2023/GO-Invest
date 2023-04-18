import DomainModels
import QuoteClient
import QuoteDetail
import UIKit

class QuoteCoordinator {
    var navigationController: UINavigationController
    var navigationTitle: String

    init(navigationController: UINavigationController, title: String) {
        self.navigationController = navigationController
        navigationTitle = title
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
//                                                print(quoteCharts.points)
                                            case let .failure(error):
                                                print("❌")
                                                print(error)
                                            }
                                        })
        let data = client.quoteStat(lisOfId: ["ABRD", "CUTR"],
                                    listOfBoardId: ["TQBR", "TQBR"],
                                    fromDate: dateFromString(str: "2021-03-14")!,
                                    completion: { result in
            switch result {
            case .success(let list):
                print("✅")
                for element in list {
                    print(element?.points.count)
                }
            case .failure(let error):
                print("❌")
                print(error)
            }

        })
        let viewController = QuoteDetailViewController()
        viewController.title = navigationTitle
        navigationController.pushViewController(viewController, animated: true)
    }
    //TODO: #<26 issue, функция как пример для конвертации данных>
    func dateFromString(str: String?) -> Date? {
        guard let str = str else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        return dateFormatter.date(from: str)
    }
}
