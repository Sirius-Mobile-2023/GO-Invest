import UIKit
import SwiftUI
import Theme
import SkeletonView
import DomainModels

class QuoteDetailView: UIView {
    typealias AddToFavsandler = () -> Void

    var addToFavsHandler: (AddToFavsandler)?

    private let graphView: UIHostingController<GraphView> = {
        let graphView = GraphView()
        let hostingController = UIHostingController(rootView: graphView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()

    private let buttonView: TimeIntervalsControl = {
        let control = TimeIntervalsControl(intervals: ["1D", "7D", "1M", "3M", "1Y"], selectedSegmentIndex: 0)
        control.isSkeletonable = true
        control.skeletonCornerRadius = Theme.StyleElements.skeletonCornerRadius
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let lastDateTextLabel = UILabel()
    private let lastDateLabel = UILabel()

    private let closePriceLabel = UILabel()
    private let closePriceAmountLabel = UILabel()

    private let openPriceLabel = UILabel()
    private let openPriceAmountLabel = UILabel()

    private let averagePriceLabel = UILabel()
    private let averagePriceAmountLabel = UILabel()

    private let mainStackView = UIStackView()
    let detailLabelsStackView = UIStackView()
    private let dateStackView = UIStackView()
    private let openPriceStackView = UIStackView()
    private let closePriceStackView = UIStackView()
    private let averagePriceStackView = UIStackView()

    private let addToFavsButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = Theme.Colors.button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Theme.StyleElements.buttonCornerRadius
        button.setTitle("Add to Favorites", for: .normal)
        button.setTitleColor(Theme.Colors.buttonText, for: .normal)
        button.setTitleColor(Theme.Colors.buttonHighlightedText, for: .highlighted)
        button.setTitleColor(Theme.Colors.buttonHighlightedText, for: .disabled)
        button.titleLabel?.font = Theme.Fonts.button
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isSkeletonable = true
        button.skeletonCornerRadius = Theme.StyleElements.skeletonCornerRadius
        button.addTarget(self, action: #selector(addToFavoritesTapped(_:)), for: .touchUpInside)
        button.setTitle("Added to Favorites", for: .disabled)
        return button
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        applyStyleForLabel(for: lastDateTextLabel, text: "Date")
        applyStyleForLabel(for: closePriceLabel, text: "Close price")
        applyStyleForLabel(for: openPriceLabel, text: "Open price")
        applyStyleForLabel(for: averagePriceLabel, text: "Average price")
        applyStyleForAmountLabel(for: lastDateLabel, text: "10.10.1010")
        applyStyleForAmountLabel(for: closePriceAmountLabel, text: "1000 $")
        applyStyleForAmountLabel(for: openPriceAmountLabel, text: "1000 $")
        applyStyleForAmountLabel(for: averagePriceAmountLabel, text: "1000 $")
    }

    private func setupLayout() {
        arrangeStackView(
            for: dateStackView,
            subviews: [lastDateTextLabel, lastDateLabel]
        )
        arrangeStackView(
            for: closePriceStackView,
            subviews: [closePriceLabel, closePriceAmountLabel]
        )
        arrangeStackView(
            for: openPriceStackView,
            subviews: [openPriceLabel, openPriceAmountLabel]
        )
        arrangeStackView(
            for: averagePriceStackView,
            subviews: [averagePriceLabel, averagePriceAmountLabel]
        )
        arrangeStackView(
            for: detailLabelsStackView,
            subviews: [dateStackView,
                       closePriceStackView,
                       openPriceStackView,
                       averagePriceStackView
                       ],
            spacing: Theme.Layout.smallSpacing,
            axis: .vertical
        )
        arrangeStackView(
            for: mainStackView,
            subviews: [graphView.view,
                       buttonView,
                       detailLabelsStackView,
                       addToFavsButton
                       ],
            spacing: Theme.Layout.bigSpacing,
            axis: .vertical
        )
        setContentHuggingPriorities()
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            graphView.view.heightAnchor.constraint(equalToConstant: 300),
            buttonView.heightAnchor.constraint(equalToConstant: 40),
            addToFavsButton.heightAnchor.constraint(equalToConstant: Theme.Layout.buttonHeight),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),

        ])
    }

    private func setContentHuggingPriorities() {
        averagePriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        averagePriceAmountLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        openPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        openPriceAmountLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        closePriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        closePriceAmountLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lastDateTextLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lastDateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

// MARK: - Apply style to UI Elements

private extension QuoteDetailView {
    func applyStyleForLabel(
        for label: UILabel,
        text: String) {
            label.text = text
            label.isSkeletonable = true
            label.linesCornerRadius = Theme.StyleElements.skeletonTextCornerRadius
            label.font = Theme.Fonts.subtitle
        }

    func applyStyleForAmountLabel(
        for label: UILabel,
        text: String) {
            label.text = text
            label.isSkeletonable = true
            label.linesCornerRadius = Theme.StyleElements.skeletonTextCornerRadius
            label.textAlignment = .right
            label.font = Theme.Fonts.title
        }

    func arrangeStackView(
        for stackView: UIStackView,
        subviews: [UIView],
        spacing: CGFloat = 0,
        axis: NSLayoutConstraint.Axis = .horizontal,
        distribution: UIStackView.Distribution = .fill,
        aligment: UIStackView.Alignment = .fill
    ) {
        stackView.isSkeletonable = true
        stackView.skeletonCornerRadius = Theme.StyleElements.skeletonCornerRadius
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = aligment
        stackView.translatesAutoresizingMaskIntoConstraints = false
        subviews.forEach { item in stackView.addArrangedSubview(item)
        }
    }
}

extension QuoteDetailView {
    func setDetailsData(quoteDetailData: QuoteDetail) {
        closePriceAmountLabel.text = "\(getRoundedValue(quoteDetailData.closePrice))"
        openPriceAmountLabel.text = "\(getRoundedValue(quoteDetailData.openPrice))"
        averagePriceAmountLabel.text = "\(getRoundedValue(quoteDetailData.currentPrice))"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        lastDateLabel.text = dateFormatter.string(from: quoteDetailData.date)
    }

    func getRoundedValue(_ number: Decimal, symbolNumber: Int = 4) -> Decimal {
        var localCopy = number
        var rounded = Decimal()
        NSDecimalRound(&rounded, &localCopy, 4, .plain)
        return rounded
    }
}

extension QuoteDetailView {
    @objc private func addToFavoritesTapped(_ sender: UIButton) {
        addToFavsHandler?()
        disableButton()
    }
}

extension QuoteDetailView {
    func disableButton() {
        addToFavsButton.isEnabled = false
    }
}
