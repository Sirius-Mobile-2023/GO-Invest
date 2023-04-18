import Foundation
import DomainModels
import FirebaseFirestore

public class Storage {
    public static var sharedQuotes: [Quote] = []
    static let database = Firestore.firestore()

    public static func putQuoteToStorage(_ quote: Quote) {
        let isInStorage = isInFavs(quote)
        if !isInStorage {
            Storage.sharedQuotes.append(quote)
        }
    }

    public static func getFavQuotesFromStorage() -> [Quote] {
        var quotesFromStorage: [Quote] = []
        let docRef = database.collection("quotes")
        docRef.getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let openPrice = data["openPrice"] as? Decimal ?? Decimal(0.0)
                    let closePrice = data["closePrice"] as? Decimal ?? Decimal(0.0)
                    DispatchQueue.main.async {
                        let quoteFromStorage = Quote(id: document.documentID, name: name, openPrice: openPrice, closePrice: closePrice)
                        print(quoteFromStorage)
                        quotesFromStorage.append(quoteFromStorage)
                        print("quotes from storage \(quotesFromStorage)")
                    }
                }
            }
        }
        print("quotes from storage \(quotesFromStorage)")
        return quotesFromStorage
    }

    public static func removeFromStorageByIndex(_ index: Int) {
        Storage.sharedQuotes.remove(at: index)
    }

    public static func isInFavs(_ quote: Quote) -> Bool {
        return Storage.sharedQuotes.contains(where: {quoteInArray in
            quoteInArray.id == quote.id})
    }
}
