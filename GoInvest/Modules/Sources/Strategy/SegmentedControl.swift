import UIKit
import Theme

class SegmentedControl: UIView {

    var selectedSegmentIndex: Int {
        didSet {
            updateSegments(
                selectedSegmentIndex: selectedSegmentIndex,
                oldSelectedSegmentIndex: oldValue
            )
        }
    }

    private var segments = [UIButton]()

    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constants.titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init(
        title: String,
        segmentsTitle: [String],
        selectedSegmentIndex: Int = Constants.defaultSelectedSegmentIndex
    ) {
        if selectedSegmentIndex >= segmentsTitle.count || selectedSegmentIndex < 0 {
            self.selectedSegmentIndex = Constants.defaultSelectedSegmentIndex
        } else {
            self.selectedSegmentIndex = selectedSegmentIndex
        }
        super.init(frame: .zero)
        setupUI(title: title, segmentsTitle: segmentsTitle)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(title: String, segmentsTitle: [String]) {
        self.title.text = title
        for (index, segment) in segmentsTitle.enumerated() {
            let button = UIButton(
                title: segment,
                titleColor: Constants.defaultTitleColor,
                backgroundColor: Constants.defaultBackgroundColor,
                borderColor: Constants.defaultBorderColor,
                cornerRadius: Constants.cornerRadius,
                borderWidth: Constants.borderWidth,
                font: Constants.buttonFont
            )

            if index == selectedSegmentIndex {
                button.layer.borderColor = Constants.selectBorderColor.cgColor
                button.setTitleColor(Constants.selectTitleColor, for: .normal)
                button.backgroundColor = Constants.selectedBackgroundColor
                button.transform = CGAffineTransform(
                    scaleX: Constants.selectSize,
                    y: Constants.selectSize
                )
            }

            segments.append(button)
            stackView.addArrangedSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ])
        }
    }

    private func setupLayout() {
        addSubview(title)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.widthAnchor.constraint(equalTo: widthAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func updateSegments(selectedSegmentIndex: Int, oldSelectedSegmentIndex: Int) {
        segments.forEach { button in
            button.isSelected = false
        }

        segments[selectedSegmentIndex].isSelected.toggle()
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.segments[oldSelectedSegmentIndex].transform = CGAffineTransform(scaleX: 1, y: 1)
                self.segments[oldSelectedSegmentIndex].backgroundColor = Constants.defaultBackgroundColor
                self.segments[oldSelectedSegmentIndex].layer.borderColor = Constants.defaultBorderColor.cgColor
                self.segments[oldSelectedSegmentIndex].setTitleColor(Constants.defaultTitleColor, for: .normal)
                self.segments[selectedSegmentIndex].transform = CGAffineTransform(
                    scaleX: Constants.selectSize,
                    y: Constants.selectSize
                )
                self.segments[selectedSegmentIndex].backgroundColor = Constants.selectedBackgroundColor
                self.segments[selectedSegmentIndex].layer.borderColor = Constants.selectBorderColor.cgColor
                self.segments[selectedSegmentIndex].setTitleColor(Constants.selectTitleColor, for: .normal)
                self.layoutIfNeeded()
            }, completion: { _ in
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            })
    }
}

extension SegmentedControl {
    @objc
    private func buttonTapped(button: UIButton) {
        selectedSegmentIndex = button.tag
    }
}

private extension SegmentedControl {
    struct Constants {
        static let defaultSelectedSegmentIndex = 0
        static let selectedBackgroundColor = Theme.Colors.button
        static let defaultBackgroundColor = UIColor.clear
        static let selectTitleColor = Theme.Colors.buttonText
        static let defaultTitleColor = Theme.Colors.button
        static let selectBorderColor = Theme.Colors.button
        static let defaultBorderColor = Theme.Colors.button
        static let cornerRadius: CGFloat = Theme.StyleElements.buttonCornerRadius
        static let borderWidth: CGFloat = Theme.StyleElements.buttonBorderWidth
        static let buttonFont = Theme.Fonts.button
        static let titleFont = Theme.Fonts.subtitle
        static let selectSize: CGFloat = Theme.Animation.selectSizeButton
        static let spacing: CGFloat = 20
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
        font: UIFont
    ) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
