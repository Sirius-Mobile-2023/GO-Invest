import Foundation

public struct QuoteCharts {

    public typealias Point = (date: Date, price: Decimal)
    public let points: [Point]?

    public init(
        points: [Point]?
    ) {
        self.points = points
    }
}
