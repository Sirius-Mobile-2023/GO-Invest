import DomainModels
import Foundation

public final class QuoteClient: DetailProvider, ChartsProvider, QuoteListProvider {
    
    public func quoteCharts(id: String, completion: (_: Result<QuoteCharts, Error>) -> Void) {
        // make get response to server
    }
    
    public func quoteDetail(id: String, completion: (_: Result<QuoteDetail, Error>) -> Void) {
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
    
    public func quoteList(search: SearchForList, completion: (_: Result<[Quote], Error>) -> Void) {
        let quoteListResult = getQuoteListBySearch(search: search)
        let quoteList: Result<[Quote], Error>
        switch quoteListResult {
        case let .success(quoteLR):
            quoteList = Result.success(quoteLR.compactMap { $0.toQuote() })
        case let .failure(error):
            quoteList = Result.failure(error)
        }
        completion(quoteList)
    }

    private func getQuoteListBySearch(search _: SearchForList) -> Result<[QuoteResult], Error> {
        // make get response to server
        return Result.failure(fatalError("Write code!!! QuoteListClient.getQuoteListByUrl"))
    }
    

    private func getQuoteDetailById(id _: String) -> Result<QuoteDetailResult, Error> {
        // make get response to server
        return .failure(fatalError("Write code!!! QuoteDetailClient.getQuoteDetailById"))
    }
    
}
