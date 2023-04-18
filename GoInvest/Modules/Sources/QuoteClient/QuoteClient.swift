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
    ) {
        let urlComponentGetCharts = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/\(boardId)/securities/\(id)/candels.json?"
        getHundredtChartsAfterDate(array: [],
                                   fromDate: fromDate,
                                   urlComponentGetCharts: urlComponentGetCharts,
                                   callback: completion)
    }

    private func getHundredtChartsAfterDate(
        array: [Point],
        fromDate: Date,
        urlComponentGetCharts: String,
        callback: @escaping (_: Result<QuoteCharts, Error>) -> Void
    ) {
        let url = URL(string: urlComponentGetCharts + "from=\(String(date: fromDate))")
        guard let url = url else {
            DispatchQueue.main.async {
                callback(.failure(ClientError.algorithmError))
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                callback(.failure(ClientError.getRequestError))
                return
            }
            do {
                let quotChartsResult = try self.decoder.decode(QuoteChartsResult.self, from: data)
                let result = quotChartsResult.toQuoteCharts()
                switch result {
                case let .success(quotCharts):
                    DispatchQueue.main.async {
                        let points = quotCharts.points
                        var newArray = array
                        newArray.append(contentsOf: points)
                        if points.count > 1 {
                            self.getHundredtChartsAfterDate(
                                array: newArray,
                                fromDate: points[points.count - 1].date,
                                urlComponentGetCharts: urlComponentGetCharts,
                                callback: callback
                            )
                        } else {
                            callback(.success(QuoteCharts(points: newArray)))
                        }
                    }
                case .failure:
                    DispatchQueue.main.async {
                        callback(result)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    callback(.failure(ClientError.decodeJsonError))
                }
            }
        }
        task.resume()
    }

    public func quoteDetail(
        id: String,
        boardId: String,
        completion: @escaping (_: Result<QuoteDetail, Error>) -> Void
    ) {
        // swiftlint:disable:next line_length
        let urlComponentGetCharts = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/\(boardId)/securities/\(id)/candels.json?sort_order=desc"

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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY-MM-dd"
        self = dateFormatter.string(from: date)
    }
}
