import DomainModels
import Foundation

struct QuoteDetailResult: Decodable {
    //  fields...

    func toQuoteDetail() -> Result<QuoteDetail, Error> {
        return Result.failure(fatalError("Write code!!! QuoteDetailResulttoQuoteDetail"))
    }
}
