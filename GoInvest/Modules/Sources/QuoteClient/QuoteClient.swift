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
    private let queueTrack = DispatchQueue(label: "queueTrack")

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
//        let urlComponentGetCharts = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/\(boardId)/securities/\(id)/candels.json?"
//        var charts = QuoteCharts(points: [])
//
//
//            switch result {
//            case .success(let quoteCharts):
//                let points = quoteCharts.points
//                charts.points.append(contentsOf: points)
//                if points.count == 100 {
//                    geHundredtChartsAfterDate(fromDate: fromDate,
//                                              urlComponentGetCharts: urlComponentGetCharts,
//                                              callback: completion)
//                } else {
//                    DispatchQueue.main.async {
//                        completion(result)
//                    }
//                }
//            case .failure:
//                DispatchQueue.main.async {
//                    completion(result)
//                }
//            }
//
//
//        geHundredtChartsAfterDate(fromDate: fromDate,
//                                  urlComponentGetCharts: urlComponentGetCharts,
//                                  callback: { result in
//            switch result {
//            case .success(let quoteCharts):
//                let points = quoteCharts.points
//                charts.points.append(contentsOf: points)
//                if points.count == 100 {
//
//                } else {
//                    DispatchQueue.main.async {
//                        completion(.success(charts))
//                    }
//                }
//            case .failure:
//                DispatchQueue.main.async {
//                    completion(result)
//                }
//            }
//
//        })
//
//        DispatchQueue.main.async {
//            completion(.success(charts))
//        }
    }
//    private func geHundredtChartsAfterDate(
//        fromDate: Date,
//        urlComponentGetCharts: String,
//        callback: @escaping (_: Result<QuoteCharts, Error> ) -> Void
//    ) {
//        print("run get")
//        let url = URL(string: urlComponentGetCharts + "from=\(String(date: fromDate))")
//        guard let url = url else {
//            DispatchQueue.main.async {
//                callback(.failure(ClientError.algorithmError))
//            }
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        let task = session.dataTask(with: request) {data, _, _ in
//            guard let data = data else {
//                callback(.failure(ClientError.getRequestError))
//                return
//            }
//            do {
//                let quotCharts = try self.decoder.decode(QuoteChartsResult.self, from: data)
//                DispatchQueue.main.async {
//                    let points = quoteCharts.points
////                    charts.points.append(contentsOf: points)
//                    if points.count == 100 {
//
//                        geHundredtChartsAfterDate(fromDate: points[points.count - 1],
//                                                  urlComponentGetCharts: urlComponentGetCharts,
//                                                  callback: callback)
//                    } else {
//                        DispatchQueue.main.async {
//                            callback(.success(quotCharts))
//                        }
//                    }
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    callback(.failure(ClientError.decodeJsonError))
//                }
//            }
//        }
//        task.resume()
//
//        DispatchQueue.main.async {[charts]
//            print("=")
//            let result  = quotCharts!.toQuoteCharts()
//            switch result {
//            case .success(let quoteCharts):
//                var copy = charts
//                copy.points.append(contentsOf: quoteCharts.points)
//                let lastPointsSize = quoteCharts.points.count
//                if lastPointsSize == 100 {
//                    let newDate = quoteCharts.points[lastPointsSize - 1].date
//                    self.geHundredtChartsAfterDate(charts: copy,
//                                                   fromDate: newDate,
//                                                   urlComponentGetCharts: urlComponentGetCharts,
//                                                   callback: callback)
//                } else {
//
//                    callback(.success(charts))
//                }
//            case .failure:
//                DispatchQueue.main.async {
//                    callback(result)
//                }
//            }
//        }
//    }

    public func quoteDetail(
        id: String,
        boardId: String,
        completion: @escaping(_: Result<QuoteDetail, Error>) -> Void) {
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

//public func quoteCharts(
//        id: String,
//        boardId: String,
//        fromDate: Date,
//        completion: @escaping (_: Result<QuoteCharts, Error>) -> Void
//) {
//    let urlComponentGetCharts = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/\(boardId)/securities/\(id)/candels.json?"
//    var charts = QuoteCharts(points: [])
//
//
//    geHundredtChartsAfterDate(fromDate: fromDate,
//                              urlComponentGetCharts: urlComponentGetCharts,
//                              callback: { result in
//        switch result {
//        case .success(let quoteCharts):
//            let points = quoteCharts.points
//            charts.points.append(contentsOf: points)
//            if points.count == 100 {
//
//            } else {
//                DispatchQueue.main.async {
//                    completion(.success(charts))
//                }
//            }
//        case .failure:
//            DispatchQueue.main.async {
//                completion(result)
//            }
//        }
//
//    })
//
//    DispatchQueue.main.async {
//        completion(.success(charts))
//    }
//}
//private func geHundredtChartsAfterDate(
//    fromDate: Date,
//    urlComponentGetCharts: String,
//    callback: @escaping (_: Result<QuoteCharts, Error> ) -> Void
//) {
//    print("run get")
//    let url = URL(string: urlComponentGetCharts + "from=\(String(date: fromDate))")
//    guard let url = url else {
//        DispatchQueue.main.async {
//            callback(.failure(ClientError.algorithmError))
//        }
//        return
//    }
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    let task = session.dataTask(with: request) {data, _, _ in
//        guard let data = data else {
//            callback(.failure(ClientError.getRequestError))
//            return
//        }
//        do {
//            let quotCharts = try self.decoder.decode(QuoteChartsResult.self, from: data)
//            DispatchQueue.main.async {
//                callback(quotCharts.toQuoteCharts())
//            }
//        } catch {
//            DispatchQueue.main.async {
//                callback(.failure(ClientError.decodeJsonError))
//            }
//        }
//    }
//    task.resume()
//
//    DispatchQueue.main.async {[charts]
//        print("=")
//        let result  = quotCharts!.toQuoteCharts()
//        switch result {
//        case .success(let quoteCharts):
//            var copy = charts
//            copy.points.append(contentsOf: quoteCharts.points)
//            let lastPointsSize = quoteCharts.points.count
//            if lastPointsSize == 100 {
//                let newDate = quoteCharts.points[lastPointsSize - 1].date
//                self.geHundredtChartsAfterDate(charts: copy,
//                                               fromDate: newDate,
//                                               urlComponentGetCharts: urlComponentGetCharts,
//                                               callback: callback)
//            } else {
//
//                callback(.success(charts))
//            }
//        case .failure:
//            DispatchQueue.main.async {
//                callback(result)
//            }
//        }
//    }
//}
