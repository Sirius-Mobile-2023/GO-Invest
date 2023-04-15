import UIKit

public class QuoteDetailViewController: UIViewController {
    
    private lazy var control: TimeIntervalsControl = {
        let control = TimeIntervalsControl(intervals: ["1D", "7D", "1M", "3M", "1Y"], selectedSegmentIndex: 4)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(control)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            control.heightAnchor.constraint(equalToConstant: 45),
            control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
