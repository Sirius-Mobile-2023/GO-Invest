import DomainModels
import UIKit

final class QuoteCustomCell: UITableViewCell {
    private let shortNameLabel = UILabel()
    private let priceLabel = UILabel()
    private let diffPriceLabel = UILabel()
    private let diffPercentLabel = UILabel()
    private let leadingStackView = UIStackView()
    private let trailingStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStacks()
        configureShortNameLabel()
        configurePriceLabel()
        configureDiffPriceLabel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStacks() {
        configureDiffStackView()
        configureNamePriceStackView()
    }

    private func configureDiffStackView() {
        trailingStackView.axis = .vertical
        trailingStackView.alignment = .fill
        trailingStackView.distribution = .fillEqually
        trailingStackView.spacing = 10
        trailingStackView.addArrangedSubview(diffPercentLabel)
        trailingStackView.addArrangedSubview(diffPriceLabel)
        contentView.addSubview(trailingStackView)

        trailingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trailingStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trailingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }

    private func configureNamePriceStackView() {
        leadingStackView.axis = .horizontal
        leadingStackView.alignment = .fill
        leadingStackView.distribution = .fill
        leadingStackView.addArrangedSubview(shortNameLabel)
        leadingStackView.addArrangedSubview(priceLabel)
        contentView.addSubview(leadingStackView)

        leadingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leadingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leadingStackView.trailingAnchor.constraint(equalTo: trailingStackView.leadingAnchor,
                                                       constant: -30),
        ])
        shortNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    }

    private func configureShortNameLabel() {
        shortNameLabel.numberOfLines = 0
        shortNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
    }

    private func configurePriceLabel() {
        priceLabel.numberOfLines = 0
        priceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        priceLabel.textAlignment = .right
    }

    private func configureDiffPriceLabel() {
        diffPriceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        diffPriceLabel.textAlignment = .right
    }

    func setData(model: Quote) {
        shortNameLabel.text = model.name
        if let openPrice = model.openPrice, let closePrice = model.closePrice {
            let diff = openPrice - closePrice
            priceLabel.text = "$\(closePrice.rounded(2, .plain))"
            diffPriceLabel.text = "\(diff.rounded(2, .plain))"
            
            let percent = diff / openPrice * 100
            if diff < 0 {
                diffPercentLabel.text = "\(percent.rounded(2, .plain))%"
                diffPercentLabel.textColor = .red
            } else {
                diffPercentLabel.textColor = UIColor(red: 23 / 255, green: 143 / 255, blue: 31 / 255, alpha: 1)
                diffPercentLabel.text = "+\(percent.rounded(2, .plain))%"
            }
        } else {
            priceLabel.text = "$---"
            diffPercentLabel.text = "---"
            diffPriceLabel.text = "---%"
        }
    }
}

extension Decimal {
    mutating func round(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) {
        var localCopy = self
        NSDecimalRound(&self, &localCopy, scale, roundingMode)
    }

    func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        return result
    }
}
