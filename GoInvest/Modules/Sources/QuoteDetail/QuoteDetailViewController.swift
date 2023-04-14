import UIKit

public class QuoteDetailViewController: UIViewController {
    
    private lazy var control: TimeIntervalsControl = {
        let control = TimeIntervalsControl(intervals: ["1D", "7D", "1M", "1Y"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(control)
        
        control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
        control.heightAnchor.constraint(equalToConstant: 40).isActive = true
        control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
