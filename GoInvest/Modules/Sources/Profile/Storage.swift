import Foundation
import DomainModels
import FirebaseFirestore

public class Storage {
    public static var sharedQuotesIds: [String] = []
    private static let database = Firestore.firestore()
    private static let dbName = "quoteIds"
    private static let targetField = "id"

    public static func fetchDataFromStorage() {
        database.collection(dbName).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            Storage.sharedQuotesIds = documents.map { queryDocumentSnapshot -> String in
                let data = queryDocumentSnapshot.data()
                let id = data[targetField] as? String ?? ""
                return id
            }
        }
    }

    public static func putQuoteToStorage(_ quote: Quote) {
        let isInStorage = isInFavs(quote)
        if !isInStorage {
            database.collection(dbName).addDocument(data: [
                targetField: quote.id
            ])
        }
    }

    public static func getFavQuotesFromStorage() -> [String] {
        return sharedQuotesIds
    }

    public static func removeFromStorageByIndex(_ index: Int) {
        database.collection(dbName).whereField(targetField, isEqualTo: Storage.sharedQuotesIds[index]).getDocuments { querySnapshot, err in
            if err != nil {
                return
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
        Storage.sharedQuotesIds.remove(at: index)
    }

    public static func isInFavs(_ quote: Quote) -> Bool {
        return Storage.sharedQuotesIds.contains(where: {quoteId in
            quoteId == quote.id})
    }
}
