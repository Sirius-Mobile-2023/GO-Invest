import UIKit
import Theme
import QuoteClient
import DomainModels
import SkeletonView

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
    private var chartDataClient: ChartsProvider? = QuoteClient()
    private var graphState: GraphState = .none {
        didSet {
            switch graphState {
            case .load:
                view.showAnimatedGradientSkeleton()
            case .error:
                print("error")
            case .success:
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
                view.showAnimatedGradientSkeleton()
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
        stack.spacing = Theme.bigSpacing
        stack.axis = .vertical
        stack.isSkeletonable = true
        return stack
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        view.isSkeletonable = true
        quoteDetailMainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quoteDetailMainStackView)
        setupLayout()
    }
    
    override public func viewDidLayoutSubviews() {
        fetchDataForDetails()
        fetchDataForGraph()

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
    
    private func fetchDataForDetails(){
        detailState = .load
        quoteDetailClient?.quoteDetail(id: "null") { [self] result in
            switch result {
            case .success(let quoteDetail):
                detailState = .success
                print("success")
            case .failure(_):
                detailState = .error
                print("error")
            }
        }
    }
    
    private func fetchDataForGraph(){
        graphState = .load
        chartDataClient?.quoteCharts(id: "", boardId: "", fromDate: Date()){ [self] result in
            switch result {
            case .success(let graphData):
                self.graphState = .success
            case .failure(_):
                self.graphState = .error
            }
        }
    }
}

