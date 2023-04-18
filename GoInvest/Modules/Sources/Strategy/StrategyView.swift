import UIKit

class StrategyView: UIView {
    
    private let amountView: UIView = {
        let textField = UIView()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input Amount"
        textField.keyboardType = .numberPad
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
    
    private let computeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Compute", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(computeButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            amountView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            amountView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin),
            amountView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin),
            amountView.heightAnchor.constraint(equalToConstant: 50),
            amountTextField.topAnchor.constraint(equalTo: amountView.topAnchor),
            amountTextField.leadingAnchor.constraint(equalTo: amountView.leadingAnchor, constant: 10),
            amountTextField.trailingAnchor.constraint(equalTo: amountView.trailingAnchor),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            risksView.topAnchor.constraint(equalTo: amountView.bottomAnchor, constant: 30),
            risksView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin),
            risksView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin),
            risksView.heightAnchor.constraint(equalToConstant: 280),
            strategicsView.topAnchor.constraint(equalTo: risksView.bottomAnchor, constant: 30),
            strategicsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin),
            strategicsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin),
            strategicsView.heightAnchor.constraint(equalToConstant: 210),
            computeButton.topAnchor.constraint(equalTo: strategicsView.bottomAnchor, constant: 50),
            computeButton.heightAnchor.constraint(equalToConstant: 60),
            computeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin),
            computeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin),
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
                self.amountView.transform = CGAffineTransform(scaleX: Constants.selectSize, y: Constants.selectSize)
                self.amountView.layer.borderWidth = 2
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.amountView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.amountView.layer.borderWidth = 1
            }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        amountTextField.endEditing(true)

    }
}

private extension StrategyView {
    struct Constants {
        static let margin: CGFloat = 30
        static let cornerRadius: CGFloat = 15
        static let selectSize: CGFloat = 1.05
    }
}
