import DomainModels
import Foundation

public enum ClientError: Error {
    case getRequestError
    case algorithmError
    case decodeJsonError
    case incorrectJsonError
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

    public func quoteCharts(
            id: String,
            boardId: String,
            fromDate: Date,
            completion: @escaping (_: Result<QuoteCharts, Error>) -> Void
    ){
        let urlComponentGetCharts = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/\(boardId)/securities/\(id)/candels.json?from=\(String(date: fromDate))"
        let url = URL(string: urlComponentGetCharts)
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
                let quotCharts = try self.decoder.decode(QuoteChartsResult.self, from: data)
                DispatchQueue.main.async {
                    completion(quotCharts.toQuoteCharts())
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

    public func quoteDetail(id _: String, completion _: (_: Result<QuoteDetail, Error>) -> Void) {
        fatalError("Code will be modified")
    }
}

private extension QuoteClient {
    struct Constants {
        static let UrlComponentGetListBySearch =  "https://iss.moex.com/iss/securities.json?"
        static let UrlComponentGetDefaultList = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/tqbr/securities.json"
    }
}

private extension String {
    init(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY-MM-dd"
        self = dateFormatter.string(from: date)
    }
}
