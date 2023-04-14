import UIKit
import AudioToolbox

class TimeIntervalsControl: UIView {

    private var selectedSegmentIndex: Int
    private var segments = [IntervalButton]()
    
    private var selectorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constant.cornerRadius
        view.backgroundColor = Constant.selectBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(
        intervals: [String],
        selectedSegmentIndex: Int
    ){
        if selectedSegmentIndex >= intervals.count || selectedSegmentIndex < 0 {
            self.selectedSegmentIndex = Constant.defaultSelectedSegmentIndex
        } else {
            self.selectedSegmentIndex = selectedSegmentIndex
        }
        super.init(frame: .zero)
        var constraints: [NSLayoutConstraint] = []
        self.backgroundColor = .clear
        self.addSubview(selectorView)
        self.addSubview(stackView)
        for (index, interval) in intervals.enumerated() {
            let button = IntervalButton(
                title: interval,
                titleColor: Constant.defaultTitleColor,
                backgroundColor: Constant.defaultBackgroundColor,
                borderColor: Constant.selectBackgroundColor,
                cornerRadius: Constant.cornerRadius,
                borderWidth: Constant.borderWidth
            )
            
            if index == self.selectedSegmentIndex {
                button.setTitleColor(Constant.selectTitleColor, for: .normal)
            }
            
            segments.append(button)
            stackView.addArrangedSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            constraints.append(contentsOf: [
                button.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                button.widthAnchor.constraint(equalTo: stackView.heightAnchor)
            ])
        }
        
        constraints.append(contentsOf: [
            selectorView.widthAnchor.constraint(equalTo: segments[self.selectedSegmentIndex].widthAnchor),
            selectorView.heightAnchor.constraint(equalTo: segments[self.selectedSegmentIndex].heightAnchor),
            selectorView.leadingAnchor.constraint(equalTo: segments[self.selectedSegmentIndex].leadingAnchor),
            selectorView.topAnchor.constraint(equalTo: segments[self.selectedSegmentIndex].topAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (index, btn) in segments.enumerated() {
            btn.isSelected = false
            if btn.tag == button.tag {
                btn.isSelected.toggle()
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.selectorView.frame = btn.frame
                        self.segments[self.selectedSegmentIndex].backgroundColor = Constant.defaultBackgroundColor
                        self.segments[self.selectedSegmentIndex].setTitleColor(Constant.defaultTitleColor, for: .normal)
                        btn.backgroundColor = Constant.selectBackgroundColor
                        btn.setTitleColor(Constant.selectTitleColor, for: .normal)
                    }, completion: { _ in
                        self.selectedSegmentIndex = index
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                })
            }
        }
    }
}

private extension TimeIntervalsControl {
    struct Constant {
        static let defaultSelectedSegmentIndex = 0
        static let selectBackgroundColor = UIColor.gray
        static let defaultBackgroundColor = UIColor.clear
        static let selectTitleColor = UIColor.white
        static let defaultTitleColor = UIColor.gray
        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 1
    }
}
