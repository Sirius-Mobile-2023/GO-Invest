//
//  QuoteShort.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import Foundation

public struct QuoteShort {
    public let id: String
    public let name: String?
    public let price: Int?

    public init(id: String, name: String?, price: Int?) {
        self.id = id
        self.name = name
        self.price = price
    }
}
