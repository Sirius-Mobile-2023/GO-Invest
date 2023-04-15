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
<<<<<<< HEAD
            graphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            graphView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            graphView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            graphView.heightAnchor.constraint(equalToConstant: 300),
            buttonView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 20),
            buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonView.heightAnchor.constraint(equalToConstant: 70),
            mainStackView.topAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func applyStyleForLabel(
        for label: UILabel,
        text: String
    ) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
    }

    private func applyStyleForAmountLabel(
        for label: UILabel,
        text: String
    ) {
        label.text = text
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
    }

    private func arrangeStackView(
        for stackView: UIStackView,
        subviews: [UIView],
        spacing: CGFloat = 0,
        axis: NSLayoutConstraint.Axis = .horizontal,
        distribution: UIStackView.Distribution = .fill,
        aligment: UIStackView.Alignment = .fill
    ) {
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = aligment
        stackView.translatesAutoresizingMaskIntoConstraints = false

        subviews.forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(item)
        }
    }
=======
            quoteDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            quoteDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            quoteDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            quoteDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
>>>>>>> origin/main
}
