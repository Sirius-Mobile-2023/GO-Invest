import UIKit
import DomainModels
import QuoteClient

public class QuotesViewController: UIViewController {
    public var didTapButton: ((String) -> Void)?
    private var animationPlayed = true
    private lazy var tableView = UITableView()
    var quotesArray: [Quote] = []
    var client = QuoteClient()

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("vdls")
        tableView.alpha = 1
        if animationPlayed {
            animateTableView()
            animationPlayed = false
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        print("vdl")
        configureTitle()
        configureTableView()
        if animationPlayed {
            tableView.alpha = 0
        }
        client.quoteList(search: .defaultList) { [weak self] result in
            switch result {
            case let .success(array):
                self?.quotesArray = array
            case let .failure(error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.animateTableView()
                self?.animationPlayed = false
            }
        }
    }

    private func configureTitle() {
        title = "Quotes"
    }

    private func animateTableView() {
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
        tableView.register(QuoteCustomCell.self, forCellReuseIdentifier: "QuoteCustomCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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

extension QuotesViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        quotesArray.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCustomCell") as! QuoteCustomCell
        cell.setData(model: quotesArray[indexPath.row])
        return cell
    }

    public func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        didTapButton?("Quote")
    }
}
