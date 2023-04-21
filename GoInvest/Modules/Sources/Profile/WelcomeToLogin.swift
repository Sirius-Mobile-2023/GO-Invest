import Foundation
import UIKit
import Theme

public class WelcomeToLoginView: UIView {
    public var loginButtonHandler: (() -> Void)?
    public var regButtonHandler: (() -> Void)?

    private var stackView = UIStackView()
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .green
        self.translatesAutoresizingMaskIntoConstraints = false
        configureStackView()
        setupLayout()
    }

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = Theme.Colors.button
        button.layer.cornerRadius = Theme.StyleElements.buttonCornerRadius
        button.titleLabel?.font = Theme.Fonts.button
        button.setTitleColor(Theme.Colors.buttonText, for: .normal)
        button.setTitleColor(Theme.Colors.buttonHighlightedText, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentLogin(_ :)), for: .touchUpInside)
        return button
    }()

    private lazy var regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = Theme.Colors.button
        button.layer.cornerRadius = Theme.StyleElements.buttonCornerRadius
        button.titleLabel?.font = Theme.Fonts.button
        button.setTitleColor(Theme.Colors.buttonText, for: .normal)
        button.setTitleColor(Theme.Colors.buttonHighlightedText, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentReg(_ :)), for: .touchUpInside)
        return button
    }()

    func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        regButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        regButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        regButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(regButton)
        addSubview(stackView)
    }

    public func layoutWelcomView(superView: UIView) {
        superView.addSubview(self)
        self.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func presentLogin(_ sender: UIButton) {
        loginButtonHandler?()
    }

    @objc
    private func presentReg(_ sender: UIButton) {
        regButtonHandler?()
    }
}
