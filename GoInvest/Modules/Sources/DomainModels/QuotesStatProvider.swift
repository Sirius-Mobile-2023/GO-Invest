import Foundation

public protocol QuotesStatProvider {
    func quoteStat(
        lisOfId: [String],
        listOfBoardId: [String],
        fromDate: Date,
        completion: @escaping (Result<[QuoteCharts?], Error>) -> Void
    )
}
