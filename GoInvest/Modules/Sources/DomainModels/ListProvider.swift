import Foundation

public enum SearchForList {
    case listByString(String)
    case listDefault
}

public protocol ListProvider {
    func quoteList(search: SearchForList, completion: (_: Result<[Quote], Error>) -> Void)
}
