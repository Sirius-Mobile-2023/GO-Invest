import DomainModels
import Foundation

struct QuoteChartsResult: Decodable {

    func toQuoteCharts() -> Result<QuoteCharts, Error> {
        Result.failure(fatalError("Write code!!!"))
    }
}
