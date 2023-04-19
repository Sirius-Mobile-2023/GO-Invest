import Foundation
import QuoteClient
import DomainModels

public func getSharpStrategy() {

    func getMarketData(tikers: [String]) {
#warning ("add functionality. should return close price for stock")
        let quoteClient: QuotesStatProvider = QuoteClient()
        var allData = [[Double]]()

        quoteClient.quoteStat(listOfId: tikers, listOfBoardId: ["TQBR", "TQBR", "TQBR", "TQBR"], fromDate: Calendar.current.date(byAdding: .year, value: -1, to: .now)!) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data.count)
                for i in data {
                    var dataForQuote = [Double]()
                    print(i!.points.count)
                    for j in (i!.points) {
                        dataForQuote.append(Double(j.1.description)!)
                    }
                    allData.append(dataForQuote)
                    print(allData)
                }
            }
            print(allData)
            var portfolioSharp = [Double](repeating: 0.0, count: tikers.count)
            let returns = allData
            print(returns)
            for i in 0 ..< tikers.count {
                let sharpCoef = getSharpeCoef(returns: returns[i])
                print(sharpCoef)
                portfolioSharp[i] = sharpCoef
            }
            print("Доли активов в портфеле:")
            portfolioSharp = getPortfolioSharp(sharpList: portfolioSharp)
            print(portfolioSharp)
        }
    }

    // MARK: - func returns sharp coef
    func getSharpeCoef(returns: [Double]) -> Double {
        let length = Double(returns.count - 1)
        let mean = returns.reduce(0, +) / Double(returns.count)
        let stdDev = sqrt(returns.map { pow($0 - mean, 2) }.reduce(0, +) / length)
        return sqrt(length) * mean / stdDev
    }
    // MARK: - returns vector
    func getPortfolioSharp(sharpList: [Double]) -> [Double] {
        let absSharpList = sharpList.map(abs)
        let sumAbsSharpList = absSharpList.reduce(0, +)
        return sharpList.map { $0 / sumAbsSharpList }
    }

    getMarketData(tikers: ["ABRD", "AFLT", "AGRO", "ALRS"])
}
