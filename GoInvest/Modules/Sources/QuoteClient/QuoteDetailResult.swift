import DomainModels
import Foundation

struct QuoteDetailResult: Decodable {
    func toQuoteDetail() -> Result<QuoteDetail, Error> {
        Result.failure(fatalError("Write code!!! QuoteDetailResulttoQuoteDetail"))
    }
}
