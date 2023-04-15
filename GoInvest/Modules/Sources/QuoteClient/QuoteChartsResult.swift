import DomainModels
import Foundation

struct QuoteChartsResult: Decodable {
    let history: History
    struct History: Decodable {
        let columns: [String]
        let data: [[AnyDecodable]]
    }

    func toQuoteCharts() -> Result<QuoteCharts, Error> {
        var poinst: [Point] = []
        guard let dateIndex = history.columns.firstIndex(of: QuoteChartsResult.Constants.dateJsonName) else {
            return .failure(ClientError.incorrectJsonError)
        }
        guard let priceIndex = history.columns.firstIndex(of: QuoteChartsResult.Constants.priceJsonName) else {
            return .failure(ClientError.incorrectJsonError)
        }

        for element in history.data {
            if let dateAny = element[safe: dateIndex],
               let priceAny = element[safe: priceIndex] {
                if let date = dateFromString(str: dateAny.getStringValue()),
                   let price = priceAny.getDecimalValue() {
                    poinst.append(Point(date, price))
                }
            }
        }
        return .success(QuoteCharts(points: poinst))
    }
}

private extension QuoteChartsResult {
    struct Constants {
        static let dateJsonName = "TRADEDATE"
        static let priceJsonName = "WAPRICE"
    }
    func dateFromString(str: String?) -> Date? {
        guard let str = str else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        return dateFormatter.date(from: str)
    }
}
