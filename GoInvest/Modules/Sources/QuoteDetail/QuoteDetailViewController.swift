import UIKit

public class QuoteDetailViewController: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
    }

    private let graphView: UIView = {
        var view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let buttonView: UIView = {
        var view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let lastDateLabel = UILabel()
    private let lastDate = UILabel()

    private let closePriceLabel = UILabel()
    private let closePriceAmountLabel = UILabel()

    private let openPriceLabel = UILabel()
    private let openPriceAmountLabel = UILabel()

    private let averagePriceLabel = UILabel()
    private let averagePriceAmountLabel = UILabel()

    private let mainStackView = UIStackView()
    private let dateStackView = UIStackView()
    private let openPriceStackView = UIStackView()
    private let closePriceStackView = UIStackView()
    private let averagePriceStackView = UIStackView()

    private func setupUI() {
        applyStyleForLabel(for: lastDateLabel, text: "Date")
        applyStyleForLabel(for: closePriceLabel, text: "Close price")
        applyStyleForLabel(for: openPriceLabel, text: "Open price")
        applyStyleForLabel(for: averagePriceLabel, text: "Average price")
        applyStyleForAmountLabel(for: lastDate, text: "10.10.1010")
        applyStyleForAmountLabel(for: closePriceAmountLabel, text: "1000 $")
        applyStyleForAmountLabel(for: openPriceAmountLabel, text: "1000 $")
        applyStyleForAmountLabel(for: averagePriceAmountLabel, text: "1000 $")
    }

    func setupLayout() {
        view.addSubview(graphView)
        view.addSubview(buttonView)
        arrangeStackView(for: dateStackView, subviews: [lastDateLabel, lastDate])
        arrangeStackView(for: closePriceStackView, subviews: [closePriceLabel, closePriceAmountLabel])
        arrangeStackView(for: openPriceStackView, subviews: [openPriceLabel, openPriceAmountLabel])
        arrangeStackView(for: averagePriceStackView, subviews: [averagePriceLabel, averagePriceAmountLabel])
        arrangeStackView(for: mainStackView, subviews: [dateStackView, closePriceStackView, openPriceStackView, averagePriceStackView], axis: .vertical)
        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
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
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        text: String) {
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
}
