import UIKit
import Theme
import SkeletonView
import DomainModels

class QuoteDetailView: UIView {
    private let buttonView: UIView = {
        var view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.skeletonCornerRadius = Theme.skeletonCornerRadius
        view.isSkeletonable = true
        return view
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

    private let addToPortfolioButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = Theme.buttonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Theme.buttonCornerRadius
        button.setTitle("Add to Portfolio", for: .normal)
        button.setTitleColor(Theme.buttonTextColor, for: .normal)
        button.titleLabel?.font = Theme.Fonts.buttonFont
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isSkeletonable = true
        button.skeletonCornerRadius = Theme.skeletonCornerRadius
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
            spacing: Theme.smallSpacing,
            axis: .vertical
        )
        arrangeStackView(
            for: mainStackView,
            subviews: [buttonView,
                       detailLabelsStackView,
                       addToPortfolioButton
                      ],
            spacing: Theme.bigSpacing,
            axis: .vertical
        )
        setContentHuggingPriorities()
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            buttonView.heightAnchor.constraint(equalToConstant: 70),
            addToPortfolioButton.heightAnchor.constraint(equalToConstant: Theme.buttonHeight),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
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
            label.linesCornerRadius = Theme.skeletonLinesCornerRadius
            label.isSkeletonable = true
            label.font = Theme.Fonts.subtitleFont
        }

    func applyStyleForAmountLabel(
        for label: UILabel,
        text: String) {
            label.text = text
            label.textAlignment = .right
            label.linesCornerRadius = Theme.skeletonLinesCornerRadius
            label.isSkeletonable = true
            label.font = Theme.Fonts.titleFont
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
        stackView.skeletonCornerRadius = Theme.skeletonCornerRadius
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
        if let closePrice = quoteDetailData.closePrice,
           let openPrice = quoteDetailData.openPrice,
           let averagePrice = quoteDetailData.currentPrice,
           let lastDate = quoteDetailData.date {
            closePriceAmountLabel.text = "\(closePrice)"
            openPriceAmountLabel.text = "\(openPrice)"
            averagePriceAmountLabel.text = "\(averagePrice)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            lastDateLabel.text = dateFormatter.string(from: lastDate)
        }
    }
}
