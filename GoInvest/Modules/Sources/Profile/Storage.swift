import Foundation
import DomainModels
import FirebaseFirestore

public class Storage {
    public static var sharedQuotesIds: [String] = []
    private static let database = Firestore.firestore()
    private static let dbName = "quotes"
    private static let targetField = "id"
    private static let emailField = "owner"
    public static var currentUserEmail: String = ""

    public static func fetchDataFromStorage() {
        database.collection(dbName).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            for doc in documents {
                let data = doc.data()
                if let sender = data[emailField] as? String,
                   let id = data[targetField] as? String {
                    if sender == currentUserEmail {
                        if !isIdInFavs(id) {
                            Storage.sharedQuotesIds.append(id)
                        }
                    }
                }
            }
        }
    }

    public static func putQuoteToStorage(_ quote: Quote) {
        let isInStorage = isInFavs(quote)
        if !isInStorage {
            database.collection(dbName).addDocument(data: [
                targetField: quote.id,
                emailField: currentUserEmail
            ])
        }
    }

    public static func freeIds() {
        Storage.sharedQuotesIds = []
    }

    public static func getFavQuotesFromStorage() -> [String] {
        return sharedQuotesIds
    }

    public static func removeFromStorageByIndex(_ index: Int) {
        database.collection(dbName).whereField(targetField, isEqualTo: Storage.sharedQuotesIds[index]).whereField(emailField, isEqualTo: currentUserEmail).getDocuments { querySnapshot, err in
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

    public static func isIdInFavs(_ id: String) -> Bool {
        return Storage.sharedQuotesIds.contains(id)
    }
}
