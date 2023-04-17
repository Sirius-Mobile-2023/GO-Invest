import UIKit
import AudioToolbox
import Theme

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
    
    private let selectorView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.skeletonCornerRadius = Theme.StyleElements.skeletonCornerRadius
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = Constants.selectedBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isSkeletonable = true
        stackView.skeletonCornerRadius = Theme.StyleElements.skeletonCornerRadius
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
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
                borderColor: Constants.defaultBorderColor,
                cornerRadius: Constants.cornerRadius,
                borderWidth: Constants.borderWidth,
                sizeFont: Constants.sizeFont
            )
            
            if index == selectedSegmentIndex {
                button.setTitleColor(Constants.selectTitleColor, for: .normal)
                button.layer.borderColor = Constants.selectedBorderColor.cgColor
                button.backgroundColor = Constants.selectedBackgroundColor
            }
            
            segments.append(button)
            stackView.addArrangedSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                button.widthAnchor.constraint(equalTo: stackView.heightAnchor)
            ])
        }

        selectedSegmentConstraint = selectorView.centerXAnchor.constraint(
            equalTo: segments[selectedSegmentIndex].centerXAnchor
        )
        NSLayoutConstraint.activate([
            selectorView.centerYAnchor.constraint(equalTo: segments[selectedSegmentIndex].centerYAnchor),
            selectedSegmentConstraint,
            selectorView.heightAnchor.constraint(equalTo: segments[selectedSegmentIndex].heightAnchor),
            selectorView.widthAnchor.constraint(equalTo: segments[selectedSegmentIndex].widthAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    private func updateSegments(selectedSegmentIndex: Int, oldSelectedSegmentIndex: Int) {
        segments.forEach { button in
            button.isSelected = false
        }

        segments[selectedSegmentIndex].isSelected.toggle()
        selectedSegmentConstraint.isActive = false
        selectedSegmentConstraint = selectorView.centerXAnchor.constraint(
            equalTo: segments[selectedSegmentIndex].centerXAnchor
        )
        self.selectedSegmentConstraint.isActive = true
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.segments[oldSelectedSegmentIndex].backgroundColor = Constants.defaultBackgroundColor
                self.segments[oldSelectedSegmentIndex].layer.borderColor = Constants.defaultBorderColor.cgColor
                self.segments[oldSelectedSegmentIndex].setTitleColor(Constants.defaultTitleColor, for: .normal)
                self.segments[selectedSegmentIndex].backgroundColor = Constants.selectedBackgroundColor
                self.segments[selectedSegmentIndex].layer.borderColor = Constants.selectedBorderColor.cgColor
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
        static let selectedBorderColor = UIColor.black
        static let defaultBorderColor = UIColor.lightGray
        static let selectedBackgroundColor = UIColor.black
        static let defaultBackgroundColor = UIColor.clear
        static let selectTitleColor = UIColor.white
        static let defaultTitleColor = UIColor.black
        static let cornerRadius: CGFloat = 18
        static let borderWidth: CGFloat = 0.5
        static let sizeFont: CGFloat = 13
    }
}

private extension UIButton {
    convenience init(
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor,
        borderColor: UIColor,
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        sizeFont: CGFloat
    ) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = .systemFont(ofSize: sizeFont)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
