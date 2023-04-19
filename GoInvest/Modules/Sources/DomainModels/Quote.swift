import Foundation

public struct Quote: Codable {
    public let id: String
    public let name: String
    public let openPrice: Decimal?
    public let closePrice: Decimal?

    public init(
        id: String,
        name: String,
        openPrice: Decimal?,
        closePrice: Decimal?
    ) {
        self.id = id
        self.name = name
        self.openPrice = openPrice
        self.closePrice = closePrice
    }
}
