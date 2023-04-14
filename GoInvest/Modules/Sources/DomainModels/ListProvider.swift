import Foundation

public enum SearchForList {
    case listByName(String)
    case defaultList
}

public protocol QuoteListProvider {
    func quoteList(
        search: SearchForList,
        completion: @escaping (Result<[Quote], Error>) -> Void)
}
