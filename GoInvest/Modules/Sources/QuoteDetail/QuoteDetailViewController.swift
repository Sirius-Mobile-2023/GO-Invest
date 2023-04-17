import UIKit
import SwiftUI
import Theme

public class QuoteDetailViewController: UIViewController {

    private lazy var quoteDetailView: QuoteDetailView = {
        let view = QuoteDetailView()
        return view
    }()

    private let graphView = UIHostingController(rootView: GraphView())

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colors.background
        view.addSubview(quoteDetailView)
        setupLayout()

        addChild(graphView)
        graphView.didMove(toParent: self)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            quoteDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Layout.topOffset),
            quoteDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Layout.sideOffset),
            quoteDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Layout.sideOffset),
            quoteDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
