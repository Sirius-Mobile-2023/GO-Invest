import UIKit
import Theme
import QuoteClient
import DomainModels

enum GraphState {
    case none
    case load
    case error
    case success
}
enum DetailState {
    case none
    case load
    case error
    case success
}

public class QuoteDetailViewController: UIViewController {
    private var quoteDetailClient: DetailProvider? = QuoteClient()
    
    private var graphSpinner = UIActivityIndicatorView(style: .large)
    private var detailSpinner = UIActivityIndicatorView(style: .large)
    private var graphState: GraphState = .none {
        didSet {
            switch graphState {
            case .load:
                graphSpinner.translatesAutoresizingMaskIntoConstraints = false
                graphSpinner.hidesWhenStopped = true
                graphView.addSubview(graphSpinner)
                setupLayoutForGraphSpinner()
                graphSpinner.startAnimating()
            case .error:
                print("error")
            case .success:
                graphSpinner.stopAnimating()
                print("error")
            case .none:
                print("none")
            }
        }
    }
    private var detailState: DetailState = .none {
        didSet {
            switch detailState {
            case .load:
                quoteDetailView.addSpinnerToDetails()
            case .error:
                print("error")
            case .success:
                print("error")
            case .none:
                print("none")
            }
        }
    }
    private lazy var quoteDetailView: QuoteDetailView = {
        let view = QuoteDetailView()
        return view
    }()
    private lazy var graphView: GraphView = {
        let view = GraphView()
        return view
    }()
    private lazy var quoteDetailMainStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [graphView, quoteDetailView])
        stack.spacing = Theme.bigSpacing
        stack.axis = .vertical
        return stack
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        quoteDetailMainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quoteDetailMainStackView)
        setupLayout()
        graphState = .load
        detailState = .load
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            graphView.heightAnchor.constraint(equalToConstant: 300),
            quoteDetailMainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.topOffset),
            quoteDetailMainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.sideOffset),
            quoteDetailMainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.sideOffset),
            quoteDetailMainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupLayoutForGraphSpinner() {
        NSLayoutConstraint.activate([
            graphSpinner.centerXAnchor.constraint(equalTo: graphView.centerXAnchor),
            graphSpinner.centerYAnchor.constraint(equalTo: graphView.centerYAnchor)
        ])
    }
}

