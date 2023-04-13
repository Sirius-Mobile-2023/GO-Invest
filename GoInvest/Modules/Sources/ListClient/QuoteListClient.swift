import DomainModels
import Foundation

public final class QuoteListClient: ListProvider {
    public func quoteList(search: SearchForList, completion: (_: Result<[Quote], Error>) -> Void) {
        let quoteListResult = getQuoteListBySearch(search: search)
        let quoteList: Result<[Quote], Error>
        switch quoteListResult {
        case let .success(quoteLR):
            quoteList = Result.success(quoteLR.compactMap { $0.toQuoteShort() })
        case let .failure(error):
            quoteList = Result.failure(error)
        }
        completion(quoteList)
    }

    private func getQuoteListBySearch(search _: SearchForList) -> Result<[QuoteResult], Error> {
        // make get response to server
        return Result.failure(fatalError("Write code!!! QuoteListClient.getQuoteListByUrl"))
    }
}
