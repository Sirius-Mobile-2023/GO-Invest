import UIKit

final class QuoteCustomCell: UITableViewCell {
    private let shortNameLabel = UILabel()
    private let priceLabel = UILabel()
    private let differencePriceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(shortNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(differencePriceLabel)

        configureShortNameLabel()
        configureCostLabel()
        configureDifferenceCostLabel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureShortNameLabel() {
        shortNameLabel.numberOfLines = 0
        shortNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)

        shortNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shortNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shortNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            shortNameLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5),
        ])
    }

    private func configureCostLabel() {
        priceLabel.numberOfLines = 0
        priceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        priceLabel.textAlignment = .right

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5),
        ])
    }

    private func configureDifferenceCostLabel() {
        differencePriceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        differencePriceLabel.textAlignment = .right

        differencePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            differencePriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            differencePriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            differencePriceLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5),
        ])
    }

    func setData(model: QuoteModel) {
        shortNameLabel.text = model.shortName
        priceLabel.text = "$\(model.cost)"

        if model.costDifference < 0 {
            differencePriceLabel.text = "\(model.costDifference)%"
            differencePriceLabel.textColor = .red
        } else {
            differencePriceLabel.textColor = UIColor(red: 23 / 255, green: 143 / 255, blue: 31 / 255, alpha: 1)
            differencePriceLabel.text = "+\(model.costDifference)%"
        }
    }
}
