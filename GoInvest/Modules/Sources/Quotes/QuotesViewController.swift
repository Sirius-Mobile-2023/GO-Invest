import UIKit
import DomainModels

enum QuotesViewState {
    case load
    case error
    case success
}
public class QuotesViewController: UIViewController {
    public var didTapButton: ((String) -> Void)?
    private var animationPlayed = true
    private var quotesArray: [Quote] = []
    private lazy var tableView = UITableView()
    public var client: QuoteListProvider

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
            case let .failure(error):
                print(error)
            }
                self?.tableView.reloadData()
                self?.animateTableView()
                self?.animationPlayed = false
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

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapButton?(viewModels[indexPath.row].shortName)
    }
}

extension QuotesViewController {
    private func loadData() {
        quoteClient?.quoteList(search: .defaultList) {result in
            switch result {
            case .success(let quotesList):
                self.currentViewState = .success
                self.quotes = quotesList
            case .failure(let error):
                self.currentViewState = .error
                print(error)
            }
        }
    }
}
