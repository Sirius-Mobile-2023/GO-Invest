import UIKit
import StrategiesCount
import DomainModels
import QuoteListModel
import Theme

enum StrategyViewState {
    case load
    case success
    case error
}

public class StrategyViewController: UIViewController {
    private let modelQuoteList: ListQuoteModel
    public var performToResultsSegue: (([Quote], [Double]) -> Void)?
    private lazy var spinner = UIActivityIndicatorView(style: .large)
    private lazy var blurEffect = Theme.StyleElements.blurEffect
    private lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)

    private var viewState: StrategyViewState? {
        didSet {
            switch viewState {
            case .load:
                configureLoadView()
            case .success:
                removeLoadView()
            case .error:
                print("error occured")
            case .none:
                break
            }
        }
    }

    public init(modelQuoteList: ListQuoteModel) {
        self.modelQuoteList = modelQuoteList
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        view.addSubview(strategyView)
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            strategyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            strategyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            strategyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            strategyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

extension StrategyViewController {
    func computeStrategy(amount: Double, risk: RiskLevel, strategy: Strategy) {
        viewState = .load
        switch modelQuoteList.state {
        case .success(let quotes):
            let strategyCounter = StrategyCounter(quotes: Array(quotes[0..<20]), riskLevel: risk, strategy: strategy)
            strategyCounter.getVector(completion: { [weak self] res in
                self?.showResults(res)
                self?.viewState = .success
            })
        case .loading:
            print("Подождите, данные для листа еще не загружены!!")
        case .error(let error):
            print(error)
        }
    }
    func showResults(_ quotesSuggested: [(Quote, Double)]) {
        let quotes = quotesSuggested.map { $0.0 }
        let numbers = quotesSuggested.map { $0.1 }
        performToResultsSegue?(quotes, numbers)
    }
}

private extension StrategyViewController {
    func configureLoadView() {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func removeLoadView() {
        blurEffectView.removeFromSuperview()
        spinner.removeFromSuperview()
    }
}
