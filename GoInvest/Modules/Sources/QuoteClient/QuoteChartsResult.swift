import DomainModels
import Foundation

struct QuoteChartsResult: Decodable {
    //  fields...

    func toQuoteCharts() -> Result<QuoteCharts, Error> {
        Result.failure(fatalError("Write code!!!"))
    }
}
