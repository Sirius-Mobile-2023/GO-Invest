import UIKit
import SwiftUI
import Theme

public class QuoteDetailViewController: UIViewController {

    private lazy var quoteDetailView: QuoteDetailView = {
        let view = QuoteDetailView()
        return view
    }()

    private let graphView: UIHostingController<GraphView> = {
        let graphView = GraphView()
        let hostingController = UIHostingController(rootView: graphView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()

    private lazy var quoteDetailMainStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [graphView.view, quoteDetailView])
        stack.spacing = Theme.Layout.bigSpacing
        stack.axis = .vertical
        return stack
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()

        addChild(graphView)
        graphView.didMove(toParent: self)
    }

    func setupUI() {
        view.backgroundColor = Theme.Colors.background
        quoteDetailMainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quoteDetailMainStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            graphView.view.heightAnchor.constraint(equalToConstant: 300),
            quoteDetailMainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Layout.topOffset),
            quoteDetailMainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Layout.sideOffset),
            quoteDetailMainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Layout.sideOffset),
            quoteDetailMainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
