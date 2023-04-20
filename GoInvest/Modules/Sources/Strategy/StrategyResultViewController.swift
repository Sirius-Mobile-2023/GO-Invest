import UIKit
import Theme
import DomainModels

public class StrategyResultsViewController: UIViewController {
    public typealias ToQuoteHandler = (Quote) -> Void
    public var quotesSuggested: [Quote]?
    public var toQuoteTapped: ToQuoteHandler?

    private let toQuoteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(toQuoteTapped(button: )), for: .touchUpInside)
        button.backgroundColor = Theme.Colors.button
        button.layer.cornerRadius = Theme.StyleElements.buttonCornerRadius
        button.setTitle("To quote", for: .normal)
        button.setTitleColor(Theme.Colors.buttonText, for: .normal)
        button.titleLabel?.font = Theme.Fonts.button
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colors.background
        view.addSubview(toQuoteButton)
        setupLayout()
        view.isOpaque = false
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            toQuoteButton.heightAnchor.constraint(equalToConstant: 60),
            toQuoteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toQuoteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension StrategyResultsViewController {
    @objc
    private func toQuoteTapped(button: UIButton) {
        toQuoteTapped?(Quote(id: "ABRD", name: "ABRD", openPrice: Decimal(0.0), closePrice: Decimal(0.0)))
    }
}
