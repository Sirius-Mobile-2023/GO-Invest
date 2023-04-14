import Foundation

public struct Quote {
    public let id: String
    public let name: String
    public let price: Int?

    public init(id: String, name: String, price: Int?) {
        self.id = id
        self.name = name
        self.price = price
    }
}
