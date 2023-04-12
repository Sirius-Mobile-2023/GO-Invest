import Foundation

public protocol DetailProvider {
    func quoteDetail(id: String, completion: (_: Result<QuoteDetail, Error>) -> Void)
}
