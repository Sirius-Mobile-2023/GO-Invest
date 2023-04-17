import DomainModels
import Foundation

struct QuoteDetailResult: Decodable {
    func toQuoteDetail() -> Result<QuoteDetail, Error> {
        return Result.failure(fatalError("Write code!!! QuoteDetailResulttoQuoteDetail"))
    }
}
