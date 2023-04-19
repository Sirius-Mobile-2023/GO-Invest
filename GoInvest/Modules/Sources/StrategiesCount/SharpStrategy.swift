import Foundation

func getSharpStrategy() {
    // should return close price for stock
    func getMarketData(tiker: String, time: String) -> [Double] {
#warning ("add functionality")
        return [10.0, 10.0]
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
    let tikers = ["AAPL", "MSFT", "KO", "PEP", "TSLA", "META", "GOOG", "NFLX", "AMZN", "GE", "MCD"]
    let time = "10y"
    var portfolioSharp = [Double](repeating: 0.0, count: tikers.count)
    for i in 0 ..< tikers.count {
        let returns = getMarketData(tiker: tikers[i], time: time)
        let sharpCoef = getSharpeCoef(returns: returns)
        portfolioSharp[i] = sharpCoef
    }
    print("Доли активов в портфеле:")
    portfolioSharp = getPortfolioSharp(sharpList: portfolioSharp)
    print(portfolioSharp)
}
