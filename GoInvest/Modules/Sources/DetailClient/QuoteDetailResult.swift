//
//  QuoteDetailResult.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import DomainModels
import Foundation

struct QuoteDetailResult: Decodable {
    let id: String
    let title: String?
    let name: String?
    let price: Int?
    let date: String?
    let quoteType: String?

    public func toQuoteDetail() -> QuoteDetail? {
        return nil
    }
}
