//
//  QuoteListClient.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import DomainModels
import Foundation

public final class QuoteListClient: ProviderList {
    public func quoteList(url: URL, completion: (_ with: [QuoteShort]) -> Void) {
        guard let quoteListResult = getQuoteListByUrl(url: url) else {
            print("ERROR: get response for quoteList was completed with an errror. ")
            return
        }
        let quoteList = quoteListResult.compactMap { $0.toQuoteShort() }
        completion(quoteList)
    }

    private func getQuoteListByUrl(url _: URL) -> [QuoteShortResult]? {
        // make get response to server
        return nil
    }
}
