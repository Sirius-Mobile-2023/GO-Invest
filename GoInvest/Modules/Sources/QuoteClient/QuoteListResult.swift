import DomainModels
import Foundation

struct QuoteListResult: Decodable {
    let history: History
    struct History: Decodable {
        let columns: [String]
        let data: [[AnyDecodable]]
    }

    func toQuotes() -> [Quote] {
        var quotes: [Quote] = []
        guard let idQuoteIndex = history.columns.firstIndex(of: QuoteListResult.idJsonName) else {
            return []
        }
        guard let nameQuoteIndex = history.columns.firstIndex(of: QuoteListResult.nameJsonName) else {
            return []
        }
        let openPriceQuoteIndex = history.columns.firstIndex(of: QuoteListResult.openPriceJsonName)
        let closePriceQuoteIndex = history.columns.firstIndex(of: QuoteListResult.closePriceJsonName)
        for element in history.data {
            if let idQuoteAny = element[safe: idQuoteIndex],
               let nameQuoteAny = element[safe: nameQuoteIndex]
            {
                let openPriceQuote = element[safe: openPriceQuoteIndex ?? -1]
                let closePriceQuote = element[safe: closePriceQuoteIndex ?? -1]
                if let idQuote = idQuoteAny.getStringValue(),
                   let nameQuote = nameQuoteAny.getStringValue()
                {
                    quotes.append(
                        Quote(id: idQuote,
                              name: nameQuote,
                              openPrice: openPriceQuote?.getDecimalValue(),
                              closePrice: closePriceQuote?.getDecimalValue()))
                }
            }
        }
        return quotes
    }

    private static let idJsonName = "SECID"
    private static let nameJsonName = "SHORTNAME"
    private static let openPriceJsonName = "OPEN"
    private static let closePriceJsonName = "CLOSE"
}

struct AnyDecodable: Decodable {
    var value: Any?

    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(intValue: Int) {
            stringValue = "\(intValue)"
            self.intValue = intValue
        }

        init?(stringValue: String) { self.stringValue = stringValue }
    }

    func getIntValue() -> Int? {
        return value as? Int
    }

    func getStringValue() -> String? {
        return value as? String
    }

    func getDoubleValue() -> Double? {
        return value as? Double
    }

    func getDecimalValue() -> Decimal? {
        return value as? Decimal
    }

    init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            var result = [String: Any]()
            try container.allKeys.forEach { key throws in
                result[key.stringValue] = try container.decode(AnyDecodable.self, forKey: key).value
            }
            value = result
        } else if var container = try? decoder.unkeyedContainer() {
            var result = [Any?]()
            while !container.isAtEnd {
                result.append(try container.decode(AnyDecodable.self).value)
            }
            value = result
        } else if let container = try? decoder.singleValueContainer() {
            if let intVal = try? container.decode(Int.self) {
                value = intVal
            } else if let doubleVal = try? container.decode(Decimal.self) {
                value = doubleVal
            } else if let boolVal = try? container.decode(Bool.self) {
                value = boolVal
            } else if let stringVal = try? container.decode(String.self) {
                value = stringVal
            } else {
                value = nil
            }
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not serialise"))
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
