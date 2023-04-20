import Foundation
import UIKit
import Theme

public class WelcomeToLoginView: UIView {
    public var loginButtonHandler: (() -> Void)?

    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .green
        self.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = Theme.Colors.button
        button.layer.cornerRadius = Theme.StyleElements.buttonCornerRadius
        button.titleLabel?.font = Theme.Fonts.button
        button.setTitleColor(Theme.Colors.buttonText, for: .normal)
        button.setTitleColor(Theme.Colors.buttonHighlightedText, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentLogin(_ :)), for: .touchUpInside)
        return button
    }()

    func setupLayout() {
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }

    public func layoutWelcomView(superView: UIView) {
        superView.addSubview(self)
        self.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: Theme.Layout.topOffset),
            self.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: Theme.Layout.sideOffset),
            self.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.Layout.sideOffset),
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
}
