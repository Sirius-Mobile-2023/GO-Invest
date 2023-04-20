import UIKit
import QuoteListModel

public class StrategyViewController: UIViewController {
    private var modelQuoteList: QuoteListModel
    
    public init(modelQuoteList: QuoteListModel) {
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
