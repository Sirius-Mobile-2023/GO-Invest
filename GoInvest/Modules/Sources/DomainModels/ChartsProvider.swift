import Foundation

public protocol ChartsProvider {
    func quoteCharts(
        id: String,
        boardId: String,
        fromDate: Date,
        completion: @escaping (Result<QuoteCharts, Error>) -> Void
    )
}
