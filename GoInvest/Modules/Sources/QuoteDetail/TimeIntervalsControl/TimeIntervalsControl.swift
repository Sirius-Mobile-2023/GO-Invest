import UIKit
import AudioToolbox

class TimeIntervalsControl: UIView {

    var selectedSegmentIndex: Int {
        didSet {
            updateSegments(
                selectedSegmentIndex: selectedSegmentIndex,
                oldSelectedSegmentIndex: oldValue
            )
        }
    }
    
    private var selectedSegmentConstraint: NSLayoutConstraint!
    private var segments = [UIButton]()
    
    private var selectorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = Constants.selectedBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init (
        intervals: [String],
        selectedSegmentIndex: Int = Constants.defaultSelectedSegmentIndex
    ) {
        if selectedSegmentIndex >= intervals.count || selectedSegmentIndex < 0 {
            self.selectedSegmentIndex = Constants.defaultSelectedSegmentIndex
        } else {
            self.selectedSegmentIndex = selectedSegmentIndex
        }
        super.init(frame: .zero)
        setupLayout()
        setupUI(intervals: intervals)
    }
    
    required public init? (coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        addSubview(selectorView)
        addSubview(stackView)
    }
    
    private func setupUI(intervals: [String]) {
        for (index, interval) in intervals.enumerated() {
            let button = UIButton(
                title: interval,
                titleColor: Constants.defaultTitleColor,
                backgroundColor: Constants.defaultBackgroundColor,
                borderColor: Constants.selectedBackgroundColor,
                cornerRadius: Constants.cornerRadius,
                borderWidth: Constants.borderWidth
            )
            
            if index == self.selectedSegmentIndex {
                button.setTitleColor(Constants.selectTitleColor, for: .normal)
                button.backgroundColor = Constants.selectedBackgroundColor
            }
            
            segments.append(button)
            stackView.addArrangedSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                button.widthAnchor.constraint(lessThanOrEqualToConstant: 45)
            ])
        }

        selectedSegmentConstraint = selectorView.centerXAnchor.constraint(
            equalTo: segments[selectedSegmentIndex].centerXAnchor
        )
        NSLayoutConstraint.activate([
            selectorView.centerYAnchor.constraint(equalTo: segments[self.selectedSegmentIndex].centerYAnchor),
            selectedSegmentConstraint,
            selectorView.heightAnchor.constraint(equalTo: segments[selectedSegmentIndex].heightAnchor),
            selectorView.widthAnchor.constraint(equalTo: segments[selectedSegmentIndex].widthAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    private func updateSegments(selectedSegmentIndex: Int, oldSelectedSegmentIndex: Int) {
        segments.forEach { button in
            button.isSelected = false
        }

        segments[selectedSegmentIndex].isSelected.toggle()
        self.selectedSegmentConstraint.isActive = false
        self.selectedSegmentConstraint = self.selectorView.centerXAnchor.constraint(
            equalTo: self.segments[selectedSegmentIndex].centerXAnchor
        )
        self.selectedSegmentConstraint.isActive = true
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.segments[oldSelectedSegmentIndex].backgroundColor = Constants.defaultBackgroundColor
                self.segments[oldSelectedSegmentIndex].setTitleColor(Constants.defaultTitleColor, for: .normal)
                self.segments[selectedSegmentIndex].backgroundColor = Constants.selectedBackgroundColor
                self.segments[selectedSegmentIndex].setTitleColor(Constants.selectTitleColor, for: .normal)
                self.layoutIfNeeded()
            }, completion: { _ in
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            })
    }
}

extension TimeIntervalsControl {
    @objc
    private func buttonTapped(button: UIButton) {
        selectedSegmentIndex = button.tag
    }
}

private extension TimeIntervalsControl {
    struct Constants {
        static let defaultSelectedSegmentIndex = 0
        static let selectedBackgroundColor = UIColor.gray
        static let defaultBackgroundColor = UIColor.clear
        static let selectTitleColor = UIColor.white
        static let defaultTitleColor = UIColor.gray
        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 1
    }
}

private extension UIButton {
    convenience init(
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor,
        borderColor: UIColor,
        cornerRadius: CGFloat,
        borderWidth: CGFloat
    ) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


