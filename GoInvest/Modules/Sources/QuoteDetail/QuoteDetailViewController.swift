import UIKit
import Theme

public class QuoteDetailViewController: UIViewController {
    private lazy var quoteDetailView: QuoteDetailView = {
        let view = QuoteDetailView()
        return view
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(quoteDetailView)
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            quoteDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.topOffset),
            quoteDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.sideOffset),
            quoteDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.sideOffset),
            quoteDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
