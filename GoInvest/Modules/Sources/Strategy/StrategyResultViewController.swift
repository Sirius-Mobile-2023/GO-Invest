import UIKit
import Theme
import DomainModels

public class StrategyResultsViewController: UIViewController {
    public typealias ToQuoteHandler = (Quote) -> Void
    public var quotesSuggested: [Quote] = []
    public var toQuoteTapped: ToQuoteHandler?

    private lazy var tableView = UITableView()
    private lazy var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Go-invest suggests you to buy these quotes"
        label.font = Theme.Fonts.title
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Theme.Colors.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var animationPlayed = true

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colors.background
        view.addSubview(textLabel)
        setupLayout()
        configureTableView()
        if animationPlayed {
            tableView.alpha = 0
        }
        view.isOpaque = false
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.alpha = 1
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Table view
private extension StrategyResultsViewController {
    func applyData() {
        self.tableView.reloadData()
        self.animateTableView()
        self.animationPlayed = false
    }

    func animateTableView() {
        tableView.reloadData()

        let cells = tableView.visibleCells

        let tableViewHeight = tableView.bounds.size.height

        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }

        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75,
                           delay: Double(delayCounter) * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseOut,
                           animations: { cell.transform = CGAffineTransform.identity }, completion: nil)
            delayCounter += 1
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 90
        tableView.register(SuggestedQuoteCustomCell.self, forCellReuseIdentifier: "SuggestedQuoteCustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension StrategyResultsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        quotesSuggested.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedQuoteCustomCell") as! SuggestedQuoteCustomCell
        cell.setData(model: quotesSuggested[indexPath.row])
        return cell
    }

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        toQuoteTapped?(quotesSuggested[indexPath.row])
    }
}
