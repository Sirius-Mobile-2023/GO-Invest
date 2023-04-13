import DomainModels
import Foundation

public enum ClientError : Error {
    case urlError
    case parseDataError
    case anotherError
    
}

public final class QuoteListClient: ListProvider {
    
    private static let UrlComponentGetList = "https://iss.moex.com/iss/securities.json?"
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let decoder = JSONDecoder()
    
    public init(){}
    
    public func quoteList(search: SearchForList, completion: (_: Result<[Quote], Error>) -> Void) {
    
        // ! make resoponse with completion
        
//        let quoteListResult = getQuoteListBySearch(search: search)
//        let quoteList: Result<[Quote], Error>
//        switch quoteListResult {
//        case let .success(quoteLR):
//            quoteList = Result.success(quoteLR.toQuoteList())
//        case let .failure(error):
//            quoteList = Result.failure(error)
//        }
//        completion(quoteList)
    }

    private func getQuoteListBySearch(search: SearchForList) -> Result<QuoteListResult, Error> {
        // make get response to server
        let url : URL?
        switch search {
        case .listByString(let searchStr):
            url = URL(string: QuoteListClient.UrlComponentGetList + "q=" + searchStr)
        case .listDefault:
            url = URL(string: QuoteListClient.UrlComponentGetList)
        }
        
        guard let url = url else {
            return .failure(ClientError.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(error as Any)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jss = json
                print(jss)
            } catch {
                print("errorMsg")
            }
            
            do {
                let quoteList = try self.decoder.decode(QuoteListResult.self, from: data)
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//                quoteList.securities.data.forEach {print($0.toQuote()?.id ?? "nill" + "  " + ($0.toQuote()?.name ?? ""))}
            } catch {
                print("Can't decode data to QuoteResult. ")
                return
            }
        }
        task.resume()
        
        
        return Result.failure(ClientError.anotherError)
    }
    
}
