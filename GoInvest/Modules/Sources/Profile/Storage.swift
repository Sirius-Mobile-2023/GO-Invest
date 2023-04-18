import Foundation
import DomainModels
import FirebaseFirestore

public class Storage {
    public static var sharedQuotes: [Quote] = []
    private static let database = Firestore.firestore()

    public static func getAllData() {
        database.collection("quotes").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            Storage.sharedQuotes = documents.map { queryDocumentSnapshot -> Quote in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let openPrice = data["open price"] as? Double ?? 0.0
                let closePrice = data["close price"] as? Double ?? 0.0
                return Quote(id: id, name: name, openPrice: Decimal(openPrice),
                             closePrice: Decimal(closePrice))
            }
        }
    }

    public static func putQuoteToStorage(_ quote: Quote) {
        let isInStorage = isInFavs(quote)
        if !isInStorage {
            database.collection("quotes").addDocument(data: [
                "id": quote.id,
                "name": quote.name,
                "close price": quote.closePrice!,
                "open price": quote.openPrice!
            ])
        }
    }

    public static func getFavQuotesFromStorage() -> [Quote] {
        return sharedQuotes
    }

    public static func removeFromStorageByIndex(_ index: Int) {
        // swiftlint:disable:next line_length
        database.collection("quotes").whereField("id", isEqualTo: Storage.sharedQuotes[index].id).getDocuments { querySnapshot, err in
            if err != nil {
                return
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
        Storage.sharedQuotes.remove(at: index)
    }

    public static func isInFavs(_ quote: Quote) -> Bool {
        return Storage.sharedQuotes.contains(where: {quoteInArray in
            quoteInArray.id == quote.id})
    }
}
