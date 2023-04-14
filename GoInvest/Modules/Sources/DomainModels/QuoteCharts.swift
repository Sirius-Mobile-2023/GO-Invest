import Foundation

public typealias Point = (date: Date, price: Decimal)

public struct QuoteCharts {
    public let points: [Point]

    public init(
        points: [Point]
    ) {
        self.points = points
    }
}