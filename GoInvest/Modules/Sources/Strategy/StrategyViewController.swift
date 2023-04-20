import UIKit
import StrategiesCount
import DomainModels

public class StrategyViewController: UIViewController {
    public var performToResultsSegue: (([Quote]) -> Void)?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var strategyView: UIView = {
        title = "Strategy"
        let view = StrategyView()
        view.actionForCompute = { [weak self] amount, risk, strategy in
            let riskEnum = RiskLevel(rawValue: risk)
            let strategyEnum = Strategy(rawValue: strategy)
            self?.computeStrategy(amount: amount, risk: riskEnum!, strategy: strategyEnum!)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)

        scrollView.addSubview(strategyView)
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            strategyView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            strategyView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            strategyView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            strategyView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
        ])
    }
}

extension StrategyViewController {
    func computeStrategy(amount: Double, risk: RiskLevel, strategy: Strategy) {
        let listForTest: [Quote] = [
            Quote(id: "ABRD", name: "TQBR", openPrice: nil, closePrice: nil),
            Quote(id: "AFLT", name: "TQBR", openPrice: nil, closePrice: nil)
        ]

        let strategyCounter = StrategyCounter(quotes: listForTest, riskLevel: risk, strategy: strategy)
        strategyCounter.getVector(completion: { _ in print("end comletiona at StrategyViewController") })
        showResults()
    }

    func showResults() {
        performToResultsSegue?([
            Quote(id: "ABRD", name: "TQBR", openPrice: nil, closePrice: nil),
            Quote(id: "AFLT", name: "TQBR", openPrice: nil, closePrice: nil)
        ])
    }
}
