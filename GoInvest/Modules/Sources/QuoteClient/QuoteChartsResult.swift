import DomainModels
import Foundation

struct QuoteChartsResult: Decodable {
    //  fields...

    func toQuoteCharts() -> Result<QuoteCharts, Error> {
        return Result.failure(fatalError("Write code!!!"))
    }
}
