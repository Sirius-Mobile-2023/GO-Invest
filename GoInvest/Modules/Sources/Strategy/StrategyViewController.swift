import UIKit
import StrategiesCount
import DomainModels
import QuoteListModel

enum StrategyViewState {
    case load
    case success
    case error
}

public class StrategyViewController: UIViewController {
    private let modelQuoteList: ListQuoteModel
    public var performToResultsSegue: (([Quote]) -> Void)?
    var spinner = UIActivityIndicatorView(style: .large)
    private lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterial)
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
        print("load started")
        viewState = .load
        strategyCounter.getVector(completion: { [weak self] res in
            print("end comletiona at StrategyViewController")
            print(res)
            self?.showResults(res)
            self?.viewState = .success
        })
    }
    #warning("Paste real suggested quotes")
    func showResults(_ quotesSuggested: [Any]) {
        performToResultsSegue?([
            Quote(id: "ABRD", name: "Абрау Дюрсо", openPrice: Decimal(1000), closePrice: Decimal(1200)),
            Quote(id: "AFLT", name: "Аэрофлот", openPrice: Decimal(100), closePrice: Decimal(100))
        ])
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
