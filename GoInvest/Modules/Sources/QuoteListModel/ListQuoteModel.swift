import Foundation
import DomainModels
import Combine

public final class ListQuoteModel {
    public enum State {
        case success(quote: [Quote])
        case loading
        case error(error: Error)
    }
    @Published public private(set) var state: State

    public init(client: QuoteListProvider) {
        self.state = .loading
        client.quoteList(
            search: .defaultList,
            completion: { [weak self] result in
                switch result {
                case .success(let quoteList):
                    self?.state = .success(quote: quoteList)
                case .failure(let error):
                    self?.state = .error(error: error)
                }
            })
    }
}
