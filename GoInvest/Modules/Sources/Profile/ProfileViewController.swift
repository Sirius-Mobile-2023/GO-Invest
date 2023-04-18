import UIKit
import DomainModels

enum FavoritesViewState {
    case load
    case error
    case success
}
public class ProfileViewController: UIViewController {
    public var didTapButton: ((Quote) -> Void)?
    private var animationPlayed = true
    private var quotesArray: [Quote] = []
    private lazy var tableView = UITableView()

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.alpha = 1
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
//        fetchDataFromStorage()
        configureTitle()
        configureTableView()
        if animationPlayed {
            tableView.alpha = 0
        }
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchDataFromStorage()
        print(quotesArray)
        tableView.reloadData()
    }

    private func configureTitle() {
        title = "Favorites"
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
        tableView.register(FavoritesCustomCell.self, forCellReuseIdentifier: "FavoritesCustomCell")

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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        quotesArray.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCustomCell") as! FavoritesCustomCell
        cell.setData(model: quotesArray[indexPath.row])
        return cell
    }

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapButton?(quotesArray[indexPath.row])
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeQuoteFromStorage(at: indexPath.row)
            fetchDataFromStorage()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

private extension ProfileViewController {
    func fetchDataFromStorage() {
        quotesArray = Storage.getFavQuotesFromStorage()
    }

    func removeQuoteFromStorage(at index: Int) {
        Storage.removeFromStorageByIndex(index)
    }
}
