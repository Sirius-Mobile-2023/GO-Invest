import UIKit
import Theme

class ErrorView: UIView {
    typealias RetryHandler = () -> Void
    var tryAgainHandler: RetryHandler?

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Fonts.errorFont
        label.textColor = Theme.mainTextColor
        label.text = "Error occured"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.buttonColor
        button.layer.cornerRadius = Theme.buttonCornerRadius
        button.setTitle("Try again", for: .normal)
        button.titleLabel?.font = Theme.Fonts.buttonFont
        button.setTitleColor(Theme.buttonTextColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tryAgainButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private let errorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Theme.bigSpacing
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = Theme.backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        errorStackView.addArrangedSubview(errorLabel)
        errorStackView.addArrangedSubview(tryAgainButton)
        self.addSubview(errorStackView)
        NSLayoutConstraint.activate([
            tryAgainButton.heightAnchor.constraint(equalToConstant: Theme.buttonHeight),
            errorStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

extension ErrorView {
    @objc
    private func tryAgainButtonTapped(_ sender: UIButton) {
        tryAgainHandler?()
    }
}