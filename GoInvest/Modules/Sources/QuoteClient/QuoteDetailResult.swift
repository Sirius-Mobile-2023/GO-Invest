import DomainModels
import Foundation

struct QuoteDetailResult: Decodable {
    //  fields...

    func toQuoteDetail() -> Result<QuoteDetail, Error> {
        Result.failure(fatalError("Write code!!! QuoteDetailResulttoQuoteDetail"))
    }
}
