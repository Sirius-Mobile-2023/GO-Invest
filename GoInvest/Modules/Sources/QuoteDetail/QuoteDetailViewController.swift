import UIKit
import SwiftUI
import Theme
import QuoteClient
import DomainModels
import SkeletonView

enum GraphState {
    case load
    case error
    case success
}
enum DetailState {
    case load
    case error
    case success
}
enum QuoteDetailViewState {
    case load
    case error
    case success
}

public class QuoteDetailViewController: UIViewController {
    private var quoteDetailClient: DetailProvider? = QuoteClient()
    private var chartDataClient: ChartsProvider? = QuoteClient()
    private var graphData: QuoteCharts?
    private var detailsData: QuoteDetail?
    public var quote: Quote?

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.tryAgainHandler = { [weak self] in
            self?.getQuoteData()
        }
        return view
    }()
    private lazy var quoteDetailView: QuoteDetailView = {
        let view = QuoteDetailView()
        view.isSkeletonable = true
        return view
    }()
    private lazy var graphView: GraphView = {
        let view = GraphView()
        view.isSkeletonable = true
        return view
    }()
    private lazy var quoteDetailMainStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [graphView, quoteDetailView])
        stack.spacing = Theme.Layout.bigSpacing
        stack.axis = .vertical
        stack.isSkeletonable = true
        return stack
    }()

    private var viewState: QuoteDetailViewState? {
        didSet {
            switch viewState {
            case .load:
                view.showAnimatedGradientSkeleton()
            case .success:
                view.hideSkeleton()
                errorView.isHidden = true
                graphView.graphData = graphData
                if let quoteDetailData = detailsData {
                    quoteDetailView.setDetailsData(quoteDetailData: quoteDetailData)
                }
            case .error:
                view.addSubview(errorView)
                layoutErrorView()
            case .none:
                break
            }
        }
    }
    private var graphState: GraphState? {
        didSet {
            switch graphState {
            case .load:
                viewState = .load
            case .error:
                viewState = .error
            case .success:
                if detailState == .success {
                    viewState = .success
                }
            case .none:
                break
            }
        }
    }
    private var detailState: DetailState? {
        didSet {
            switch detailState {
            case .load:
                viewState = .load
            case .error:
                viewState = .error
            case .success:
                if graphState == .success {
                    viewState = .success
                }
            case .none:
                break
            }
        }
    }

    private let graphView = UIHostingController(rootView: GraphView())

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getQuoteData()
        setupLayout()

        addChild(graphView)
        graphView.didMove(toParent: self)
    }
}

// MARK: - UI and Layout
private extension QuoteDetailViewController {
    func setupUI() {
        view.backgroundColor = Theme.Colors.background
        view.isSkeletonable = true
        quoteDetailMainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quoteDetailMainStackView)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            graphView.heightAnchor.constraint(equalToConstant: 300),
            quoteDetailMainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Layout.topOffset),
            quoteDetailMainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Layout.sideOffset),
            quoteDetailMainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Layout.sideOffset),
            quoteDetailMainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func layoutErrorView() {
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Layout.topOffset),
            errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Layout.sideOffset),
            errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Layout.sideOffset),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Work with client
private extension QuoteDetailViewController {
    func getQuoteData() {
        getDataForGraph()
        getDataForDetails()
    }

    func getDataForDetails() {
        detailState = .load
        #warning("TODO: Paste real id")
        quoteDetailClient?.quoteDetail(id: quote?.id ?? "", boardId: "tqbr") { [weak self] result in
            switch result {
            case .success(let quoteDetail):
                self?.detailsData = quoteDetail
                self?.detailState = .success
            case .failure(let error):
                print(error)
                self?.detailState = .error
            }
        }
    }

    func getDataForGraph() {
        graphState = .load
        #warning("TODO: Paste real id")
        chartDataClient?.quoteCharts(id: quote?.id ?? "",
                                     boardId: "tqbr",
                                     fromDate: getDate(),
                                     completion: { [weak self] result in
            print(result)
            switch result {
            case .success(let graphData):
                self?.graphData = graphData
                self?.graphState = .success
            case .failure(let _):
                self?.graphState = .error
            }
        })
    }
}

private extension QuoteDetailViewController {
    func getDate() -> Date {
        let date = Calendar.current.date(byAdding: .year, value: -1, to: .now)
        return date!
    }
}
