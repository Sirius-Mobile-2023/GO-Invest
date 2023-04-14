import DomainModels
import Foundation

struct QuoteChartsResult: Decodable {

    func toQuoteCharts() -> Result<QuoteCharts, Error> {
        return Result.failure(fatalError("Write code!!!"))
    }
}
