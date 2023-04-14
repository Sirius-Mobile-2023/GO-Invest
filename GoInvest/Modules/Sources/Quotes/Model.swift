import Foundation

struct QuoteModel {
    let shortName: String
    let cost: Double
    let costDifference: Double
    static let names = ["GMVD", "CVNA", "ALLO",
                        "MSTR", "MARA", "CUTR",
                        "ONCS", "FATE", "MSTR",
                        "GOOS", "BYND", "DKFO"]
}

enum Data {
    static func getData() -> [QuoteModel] {
        var data: [QuoteModel] = []
        for _ in 1 ... 100 {
            let cost = round(Double.random(in: 30000 ... 100_000) * 100) / 100.0
            let costDifference = round(Double.random(in: -20 ... 20) * 10) / 10.0
            let name = QuoteModel.names.shuffled()[0]
            data.append(QuoteModel(shortName: name, cost: cost, costDifference: costDifference))
        }
        return data
    }
}
