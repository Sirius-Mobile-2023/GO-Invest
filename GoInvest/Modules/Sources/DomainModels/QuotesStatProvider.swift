import Foundation

public protocol QuotesStatProvider {
    func quoteStat(
        listOfId: [String],
        listOfBoardId: [String],
        fromDate: Date,
        completion: @escaping (Result<[QuoteCharts?], Error>) -> Void
    ) -> QuoteStatToken
}

public final class QuoteStatToken {
    public init() {}
    public private(set) var isCanceled = false
    public func cancel() {
        isCanceled = true
    }
}
