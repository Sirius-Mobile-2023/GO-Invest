import Foundation
import DomainModels

public class Storage {
    public static var sharedQuotes: [Quote] = []

    public static func putQuoteToStorage(_ quote: Quote) {
        let isInStorage = isInFavs(quote)
        if !isInStorage {
            Storage.sharedQuotes.append(quote)
        }
    }

    public static func getFavQuotesFromStorage() -> [Quote] {
        return Storage.sharedQuotes
    }

    public static func removeFromStorageByIndex(_ index: Int) {
        Storage.sharedQuotes.remove(at: index)
    }
    
    public static func isInFavs(_ quote: Quote) -> Bool {
        return Storage.sharedQuotes.contains(where: {quoteInArray in
            quoteInArray.id == quote.id})
    }
}
