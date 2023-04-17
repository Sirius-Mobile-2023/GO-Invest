import UIKit

public class QuoteDetailViewController: UIViewController {
    private lazy var quoteDetailView: QuoteDetailView = {
        let view = QuoteDetailView()
        return view
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(quoteDetailView)
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            quoteDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            quoteDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            quoteDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            quoteDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
