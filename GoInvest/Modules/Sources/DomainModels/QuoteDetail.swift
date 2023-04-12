import Foundation

public struct QuoteDetail {
    public enum PriceIntervals {
        case day
        case week
        case month
        case threeMonth
        case halfYear
        case year
    }

    public let id: String
    public let name: String?
    public let currentPrice: Decimal?
    public let priceInterval: PriceIntervals?
    public let date: Date?
    public let closePrice: Decimal?
    public let pointsData: (date: Date, price: Decimal)?

    public init(
        id: String,
        name: String?,
        currentPrice: Decimal?,
        priceInterval: PriceIntervals?,
        date: Date?,
        closePrice: Decimal?,
        pointsData: (date: Date, price: Decimal)?
    ) {
        self.id = id
        self.name = name
        self.currentPrice = currentPrice
        self.priceInterval = priceInterval
        self.date = date
        self.closePrice = closePrice
        self.pointsData = pointsData
    }
}
