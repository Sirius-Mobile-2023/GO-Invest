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

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        setupLayout()
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
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            toQuoteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toQuoteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toQuoteButton.widthAnchor.constraint(equalToConstant: 150),
            toQuoteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension QuotesViewController {
    @objc
    private func toQuoteTapped(_ sender: UIButton) {
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
