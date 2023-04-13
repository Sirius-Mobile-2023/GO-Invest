import DomainModels
import Foundation

public final class QuoteDetailClient: DetailProvider {
    public func quoteDetail(id: String, completion: (_: Result<QuoteDetail, Error>) -> Void) {
        
        // ! make resoponse with completion
        
        let quoteDetailResult = getQuoteDetailById(id: id)
        let quoteDetail: Result<QuoteDetail, Error>
        switch quoteDetailResult {
        case let .success(quoteDR):
            quoteDetail = quoteDR.toQuoteDetail()
        case let .failure(error):
            quoteDetail = Result.failure(error)
        }
        completion(quoteDetail)
    }

    private func getQuoteDetailById(id _: String) -> Result<QuoteDetailResult, Error> {
        // make get response to server
        return .failure(fatalError("Write code!!! QuoteDetailClient.getQuoteDetailById"))
    }
}
