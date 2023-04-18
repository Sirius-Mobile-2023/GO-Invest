import UIKit
import DomainModels

enum QuotesViewState {
    case load
    case error
    case success
}
public class QuotesViewController: UIViewController {
    public var didTapButton: ((Quote) -> Void)?
    private var animationPlayed = true
    private var arrayToShow: [Quote] = []
    private lazy var tableView = UITableView()
    public var client: QuoteListProvider
    private let searchController = UISearchController()

    private var quotesArray: [Quote] = [] {
        willSet {
            arrayToShow = newValue
            tableView.reloadData()
        }
    }

    public init(client: QuoteListProvider) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var currentViewState: QuotesViewState? {
        didSet {
            switch self.currentViewState {
            case .load:
#warning("TODO: Add load animation")
            case .error:
#warning("TODO: Add error view")
            case .success:
#warning("TODO: Add table reload")
            case .none:
                break
            }
        }
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
                self?.currentViewState = .success
            case let .failure(error):
                self?.currentViewState = .error
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
        searchController.obscuresBackgroundDuringPresentation = false
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
        searchController.searchBar.delegate = self
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

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapButton?(arrayToShow[indexPath.row])
    }
}

extension QuotesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.uppercased() else {
            return
        }
        guard !text.isEmpty else {
            return
        }
        let filteredData = quotesArray.filter { $0.name.uppercased().contains(text) || $0.id.uppercased().contains(text) }

        arrayToShow = filteredData
        tableView.reloadData()
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrayToShow = quotesArray
        tableView.reloadData()
    }
}
