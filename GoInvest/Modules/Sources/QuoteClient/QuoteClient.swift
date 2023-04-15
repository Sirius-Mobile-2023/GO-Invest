import DomainModels
import Foundation

<<<<<<< HEAD
public final class QuoteClient: DetailProvider, ChartsProvider, QuoteListProvider {
    public func quoteCharts(id _: String, completion _: (_: Result<QuoteCharts, Error>) -> Void) {
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
        Result.failure(fatalError("Write code!!! QuoteListClient.getQuoteListByUrl"))
    }

    private func getQuoteDetailById(id _: String) -> Result<QuoteDetailResult, Error> {
        // make get response to server
        .failure(fatalError("Write code!!! QuoteDetailClient.getQuoteDetailById"))
=======
public enum ClientError: Error {
    case getRequestError
    case algorithmError
    case decodeJsonError
}

public final class QuoteClient: DetailProvider, ChartsProvider, QuoteListProvider {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let decoder = JSONDecoder()
    public init() {}

    public func quoteList(search: SearchForList, completion: @escaping (_: Result<[Quote], Error>) -> Void) {
        let url: URL?
        switch search {
        case let .listByName(searchStr):
            url = URL(string: QuoteClient.Constants.UrlComponentGetListBySearch + "q=" + searchStr)
        case .defaultList:
            url = URL(string: QuoteClient.Constants.UrlComponentGetDefaultList)
        }
        guard let url = url else {
            DispatchQueue.main.async {
                completion(.failure(ClientError.algorithmError))
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ClientError.getRequestError))
                }
                return
            }
            do {
                let quotesResult = try self.decoder.decode(QuoteListResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(quotesResult.toQuotes()))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(ClientError.decodeJsonError))
                }
                return
            }
        }
        task.resume()
    }

    public func quoteCharts(id _: String, completion _: (_: Result<QuoteCharts, Error>) -> Void) {
        fatalError("Code will be modified")
    }

    public func quoteDetail(id _: String, completion _: (_: Result<QuoteDetail, Error>) -> Void) {
        fatalError("Code will be modified")
    }
}

private extension QuoteClient {
    struct Constants {
        static let UrlComponentGetListBySearch =  "https://iss.moex.com/iss/securities.json?"
        static let UrlComponentGetDefaultList = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/tqbr/securities.json"
>>>>>>> origin/main
    }
}
