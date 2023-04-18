import Foundation

public protocol DetailProvider {
    func quoteDetail(
        id: String,
        boardId: String,
        completion: @escaping (Result<QuoteDetail, Error>) -> Void
    )
}
