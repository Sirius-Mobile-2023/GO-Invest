import UIKit

class StrategyView: UIView {
    
    private let amountView: UIView = {
        let textField = UIView()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input Amount"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let risksView: SegmentedControl = {
        let view = SegmentedControl(
            title: "Risks",
            segmentsTitle: ["😀 Ligth", "🥰 Medium", "😁 Normal", "😎 Hard"]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let strategicsView: SegmentedControl = {
        let view = SegmentedControl(
            title: "Strategics",
            segmentsTitle: ["Name strategy 1", "Name strategy 2", "Name strategy 3"]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        amountTextField.delegate = self
        addSubview(amountView)
        amountView.addSubview(amountTextField)
        addSubview(risksView)
        addSubview(strategicsView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            amountView.topAnchor.constraint(equalTo: topAnchor),
            amountView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            amountView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            amountView.heightAnchor.constraint(equalToConstant: 50),
            amountTextField.topAnchor.constraint(equalTo: amountView.topAnchor),
            amountTextField.leadingAnchor.constraint(equalTo: amountView.leadingAnchor, constant: 10),
            amountTextField.trailingAnchor.constraint(equalTo: amountView.trailingAnchor),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            risksView.topAnchor.constraint(equalTo: amountView.bottomAnchor, constant: 30),
            risksView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            risksView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            risksView.heightAnchor.constraint(equalToConstant: 280),
            strategicsView.topAnchor.constraint(equalTo: risksView.bottomAnchor, constant: 30),
            strategicsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            strategicsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            strategicsView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
}

extension StrategyView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.amountView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                self.amountView.layer.borderWidth = 2
            }, completion: { _ in
                self.amountView.layer.borderWidth = 2
            })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.amountView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.amountView.layer.borderWidth = 1
            }, completion: { _ in
                self.amountView.layer.borderWidth = 1
            })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
