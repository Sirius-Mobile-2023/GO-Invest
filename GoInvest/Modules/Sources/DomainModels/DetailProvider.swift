import Foundation

public protocol DetailProvider {
    func quoteDetail(
        id: String,
        completion: (Result<QuoteDetail, Error>) -> Void
    )
}
