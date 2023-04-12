//
//  QuoteDetail.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import Foundation

public struct QuoteDetail {
    public enum QuoteType {
        case oil
        case food
    }

    public let id: String
    public let title: String?
    public let name: String?
    public let price: Int?
    public let date: Date?
    public let quoteType: QuoteType?

    public init(
        id: String,
        title: String?,
        name: String?,
        price: Int?,
        date: Date?,
        quoteType: QuoteType?
    ) {
        self.id = id
        self.title = title
        self.name = name
        self.price = price
        self.date = date
        self.quoteType = quoteType
    }
}
