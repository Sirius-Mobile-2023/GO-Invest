//
//  ProviderDetail.swift
//
//
//  Created by Grigorii Rassadnikov on 12.04.2023.
//

import Foundation

public protocol ProviderDetail {
    func quoteDetail(id: String, completion: (_ with: QuoteDetail) -> Void)
}
