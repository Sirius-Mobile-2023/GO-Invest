//
//  ProviderList.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import Foundation

public protocol ProviderList {
    func quoteList(url: URL, completion: (_ with: [QuoteShort]) -> Void)
}
