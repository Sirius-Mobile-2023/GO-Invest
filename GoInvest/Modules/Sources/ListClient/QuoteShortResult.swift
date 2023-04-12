//
//  QuoteShortResult.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import DomainModels
import Foundation

struct QuoteShortResult {
    let id: String
    let name: String?
    let price: Int?

    public func toQuoteShort() -> QuoteShort? {
        return nil
    }
}
