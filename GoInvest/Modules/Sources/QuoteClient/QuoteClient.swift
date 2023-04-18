import DomainModels
import Foundation

public enum ClientError: Error {
    case getRequestError
    case algorithmError
    case decodeJsonError
    case incorrectJsonError
}

let dateFormatter = DateFormatter()

public final class QuoteClient: DetailProvider, ChartsProvider, QuoteListProvider {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let decoder = JSONDecoder()
    private var urlComponents = URLComponents()
    public init() {
        urlComponents.scheme = "https"
        urlComponents.host = "iss.moex.com"
    }
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
    ) {
        var components = urlComponents
        components.path = "/iss/history/engines/stock/markets/shares/boards/\(boardId)/securities/\(id)/candels.json"
        getChartsAfterDate(array: [],
                           fromDate: fromDate,
                           components: components,
                           start: 0,
                           callback: completion)
    }

    private func getChartsAfterDate(
        array: [Point],
        fromDate: Date,
        components: URLComponents,
        start: Int,
        callback: @escaping (_: Result<QuoteCharts, Error>) -> Void
    ) {
        var componentsForURL = components
        componentsForURL.queryItems = [
            URLQueryItem(name: "from", value: "\(String(date: fromDate))"),
            URLQueryItem(name: "start", value: "\(start)"),
        ]
        guard let url = componentsForURL.url else {
            DispatchQueue.main.async {
                callback(.failure(ClientError.algorithmError))
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                self.obsereDataByGetChartsRequest(
                    data: data,
                    array: array,
                    components: components,
                    callback: callback
                )
            }
        }
        task.resume()
    }

    private func obsereDataByGetChartsRequest(
        data: Data?,
        array: [Point],
        components: URLComponents,
        callback: @escaping (_: Result<QuoteCharts, Error>) -> Void
    ) {
        guard let data = data else {
            callback(.failure(ClientError.getRequestError))
            return
        }
        do {
            let quoteChartsResult = try decoder.decode(QuoteChartsResult.self, from: data)
            let result = quoteChartsResult.toQuoteCharts()
            switch result {
            case let .success(quoteCharts):
                let points = quoteCharts.points
                var newArray = array
                newArray.append(contentsOf: points)
                if points.count > 1 {
                    getChartsAfterDate(
                        array: newArray,
                        fromDate: points[points.count - 1].date,
                        components: components,
                        start: 1,
                        callback: callback
                    )
                } else {
                    callback(.success(QuoteCharts(points: newArray)))
                }
            case .failure:
                callback(result)
            }
        } catch {
            callback(.failure(ClientError.decodeJsonError))
        }
    }

    public func quoteDetail(
        id: String,
        boardId: String,
        completion: @escaping (_: Result<QuoteDetail, Error>) -> Void
    ) {
        var components = urlComponents
        components.path = "/iss/history/engines/stock/markets/shares/boards/\(boardId)/securities/\(id)/candels.json"
        components.queryItems = [
            URLQueryItem(name: "sort_order", value: "desc"),
        ]
        guard let url = components.url else {
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
                    completion(quotCharts.toQuoteDetail())
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
}

private extension QuoteClient {
    enum Constants {
        static let UrlComponentGetListBySearch = "https://iss.moex.com/iss/securities.json?"
        static let UrlComponentGetDefaultList = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/tqbr/securities.json"
    }
}

private extension String {
    init(date: Date) {
        dateFormatter.dateFormat = "YY-MM-dd"
        self = dateFormatter.string(from: date)
    }
}
