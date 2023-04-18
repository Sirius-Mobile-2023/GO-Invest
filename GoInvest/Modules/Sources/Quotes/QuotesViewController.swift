import UIKit
import DomainModels

public class QuotesViewController: UIViewController {
    public var didTapButton: ((String) -> Void)?
    private var animationPlayed = true
    private var arrayToShow: [Quote] = []
    private lazy var tableView = UITableView()
    public var client: QuoteListProvider
    private let searchController = UISearchController()

    private var quotesArray: [Quote] = [] {
        willSet {
            arrayToShow = newValue
        }
    }

    public init(client: QuoteListProvider) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.alpha = 1
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureTableView()
        if animationPlayed {
            tableView.alpha = 0
        }
        fetchData()
    }

    private func fetchData() {
        client.quoteList(search: .defaultList) { [weak self] result in
            switch result {
            case let .success(array):
                self?.quotesArray = array
            case let .failure(error):
                print(error)
            }
                self?.showFullQuotes()
                self?.tableView.reloadData()
                self?.animateTableView()
                self?.animationPlayed = false
        }
    }

    private func configureTitle() {
        title = "Quotes"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }

    private func showFullQuotes() {
        quotesArray = quotesArray.filter { isFull($0) } + quotesArray.filter { !isFull($0) }
    }

    private func isFull(_ q: Quote) -> Bool {
        q.openPrice != nil && q.closePrice != nil
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
        arrayToShow.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCustomCell") as! QuoteCustomCell
        cell.setData(model: arrayToShow[indexPath.row])
        return cell
    }

    public func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        didTapButton?("Quote")
    }
}

extension QuotesViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.uppercased() else {
            return
        }
        let filteredData = quotesArray.filter { $0.name.uppercased().contains(text) || $0.id.uppercased().contains(text) }

        if filteredData.isEmpty {
            arrayToShow = quotesArray
        } else {
            arrayToShow = filteredData
        }
        tableView.reloadData()

    }
}
