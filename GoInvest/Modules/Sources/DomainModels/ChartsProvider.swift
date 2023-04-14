import Foundation

public protocol ChartsProvider {
    func quoteCharts(
        id: String,
        completion: (Result<QuoteCharts, Error>) -> Void
    )
}
