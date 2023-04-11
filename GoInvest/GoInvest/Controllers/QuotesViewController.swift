//
//  QuotesViewController.swift
//  GoInvest
//
//  Created by Анастасия Бегинина on 11.04.2023.
//

import UIKit

class QuotesViewController: UIViewController {
    var coordinator: TabBarCoordinator?
    let toQuoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("To Quote", for: .normal)
        button.backgroundColor = UIColor.systemOrange
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(toQuoteTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            toQuoteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toQuoteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toQuoteButton.widthAnchor.constraint(equalToConstant: 150),
            toQuoteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupUI() {
        view.backgroundColor = .blue
        view.addSubview(toQuoteButton)
    }
}

extension QuotesViewController {
    @objc
    private func toQuoteTapped(_ sender: UIButton) {
        coordinator?.showQuoteController(with: "Quote")
    }
}
