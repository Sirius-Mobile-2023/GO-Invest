//
//  QuoteDetailClient.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import DomainModels
import Foundation

public final class QuoteDetailClient: ProviderDetail {
    public func quoteDetail(id: String, completion: (_ with: QuoteDetail) -> Void) {
        guard let quoteDetailResult = getQuoteDetailById(id: id) else {
            print("ERROR: get response for quoteDetail was completed with an errror. ")
            return
        }
        guard let quoteDetail = quoteDetailResult.toQuoteDetail() else {
            print("ERROR: can't parse QuoteDetailResult to QuoteDetail (maybe you code is bad). ")
            return
        }
        completion(quoteDetail)
    }

    private func getQuoteDetailById(id _: String) -> QuoteDetailResult? {
        // make get response to server
        return nil
    }
}
