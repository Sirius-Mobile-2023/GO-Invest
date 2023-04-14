import Foundation

public struct QuoteDetail {
    public let id: String
    public let name: String?
    public let currentPrice: Decimal?
    public let date: Date?
    public let closePrice: Decimal?

    public init(
        id: String,
        name: String?,
        currentPrice: Decimal?,
        date: Date?,
        closePrice: Decimal?
    ) {
        self.id = id
        self.name = name
        self.currentPrice = currentPrice
        self.date = date
        self.closePrice = closePrice
    }
}
