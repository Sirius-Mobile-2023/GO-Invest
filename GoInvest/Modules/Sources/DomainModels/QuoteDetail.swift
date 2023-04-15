import Foundation

public struct QuoteDetail {
    public let id: String
    public let name: String
    public let openPrice: Decimal?
    public let currentPrice: Decimal?
    public let closePrice: Decimal?
    public let date: Date?

    public init(
        id: String,
        name: String,
        openPrice: Decimal?,
        currentPrice: Decimal?,
        closePrice: Decimal?,
        date: Date?
    ) {
        self.id = id
        self.name = name
        self.openPrice = openPrice
        self.currentPrice = currentPrice
        self.closePrice = closePrice
        self.date = date
    }
}
