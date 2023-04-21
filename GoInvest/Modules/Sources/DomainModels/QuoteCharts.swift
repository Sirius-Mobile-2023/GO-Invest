import Foundation

public typealias Point = (date: Date, price: Decimal, openPrice: Decimal, closePrice: Decimal)

public struct QuoteCharts {
    public var points: [Point]

    public init(
        points: [Point]
    ) {
        self.points = points
    }
}
