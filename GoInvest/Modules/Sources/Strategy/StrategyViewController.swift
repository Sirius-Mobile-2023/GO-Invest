import UIKit
import StrategiesCount
import DomainModels

public class StrategyViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var strategyView: UIView = {
        title = "Strategy"
        let view = StrategyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)

        scrollView.addSubview(strategyView)
        setupLayout()

        let listForTest: [Quote] = [
            Quote(id: "ABRD", name: "TQBR", openPrice: nil, closePrice: nil),
            Quote(id: "AFLT", name: "TQBR", openPrice: nil, closePrice: nil)
        ]
        let strategyCounter = StrategyCounter(quotes: listForTest, riskLevel: .low, strategy: .sharpe)
        strategyCounter.getVector(completion: { _ in print("end comletiona at StrategyViewController") })

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
