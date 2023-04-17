import UIKit
import QuoteClient
import Theme
import DomainModels

enum ViewState {
    case load
    case error
    case success
}

public class QuotesViewController: UIViewController {
    public var didTapButton: ((_ attribute: String) -> Void)?
    private var quoteClient: QuoteListProvider? = QuoteClient()
    private var quotes: [Quote]?
    private var currentViewState: ViewState? {
        didSet {
            switch self.currentViewState {
            case .load:
                self.showSpinner(onView: self.view)
            case .error:
                self.removeSpinner()
            case .success:
                self.removeSpinner()
            case .none:
                break
            }
        }
    }
    private var spinnerView: UIView?

    lazy var toQuoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("To Quote", for: .normal)
        button.backgroundColor = Theme.buttonColor
        button.layer.cornerRadius = Theme.buttonCornerRadius
        button.addTarget(self, action: #selector(toQuoteTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.alpha = 1
        if animationPlayed {
            animateTableView()
            animationPlayed = false
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureTableView()
        setupUI()
        loadData()
        setupLayout()
        if animationPlayed {
            tableView.alpha = 0
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

    private func loadData() {
        quoteClient?.quoteList(search: .defaultList) {[self] result in
            switch result {
            case .success(let quotesList):
                self.currentViewState = .success
                self.quotes = quotesList
            case .failure(_):
                self.currentViewState = .error
            }
        }
    }

    private func setupUI() {
        currentViewState = .load
        view.backgroundColor = Theme.yellowColor
        view.addSubview(toQuoteButton)

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
        viewModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCustomCell") as! QuoteCustomCell
        cell.setData(model: viewModels[indexPath.row])
        return cell
    }

    public func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        didTapButton?("Quote")
    }
}

#warning ("Change spinner to Skeleton")
private extension QuotesViewController {
    func showSpinner(onView: UIView) {
        var spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .gray
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        self.spinnerView = spinnerView
    }

    func removeSpinner() {
        DispatchQueue.main.async { [self] in
            self.spinnerView?.removeFromSuperview()
            spinnerView = nil
        }
    }
}
