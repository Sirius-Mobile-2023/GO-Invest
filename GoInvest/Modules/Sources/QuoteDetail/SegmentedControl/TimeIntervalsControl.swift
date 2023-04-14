import UIKit
import AudioToolbox

class TimeIntervalsControl: UIView {

    var selectedSegmentIndex = 0
    
    var selectorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constant.cornerRadius
        view.backgroundColor = Constant.selectBackGroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    open var segments = [IntervalButton]()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(intervals: [String]) {
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        self.addSubview(selectorView)
        self.addSubview(stackView)
        for (index, interval) in intervals.enumerated() {
            let button = IntervalButton(
                titile: interval,
                titleColor: Constant.defaultTitleColor,
                backGroundColor: Constant.defaultBackGroundColor
            )
            
            if index == selectedSegmentIndex {
                button.setTitleColor(Constant.selectTitleColor, for: .normal)
            }
            segments.append(button)
            stackView.addArrangedSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            button.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        }
        selectorView.widthAnchor.constraint(equalTo: segments[selectedSegmentIndex].widthAnchor).isActive = true
        selectorView.heightAnchor.constraint(equalTo: segments[selectedSegmentIndex].heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (index, btn) in segments.enumerated() {
            btn.isSelected = false
            if btn.tag == button.tag {
                btn.isSelected.toggle()
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [self] in
                    self.selectorView.frame = btn.frame
                    segments[selectedSegmentIndex].backgroundColor = Constant.defaultBackGroundColor
                    segments[selectedSegmentIndex].setTitleColor(Constant.defaultTitleColor, for: .normal)
                    btn.backgroundColor = Constant.selectBackGroundColor
                    btn.setTitleColor(Constant.selectTitleColor, for: .normal)
                }, completion: { _ in
                    self.selectedSegmentIndex = index
                    Vibration.light.vibrate()
                })
            }
        }
    }
}

extension TimeIntervalsControl {
    struct Constant {
        static let selectBackGroundColor = UIColor.gray
        static let defaultBackGroundColor = UIColor.clear
        static let selectTitleColor = UIColor.white
        static let defaultTitleColor = UIColor.gray
        static let cornerRadius: CGFloat = 15
    }
}

extension TimeIntervalsControl {
    enum Vibration {
          case error
          case success
          case warning
          case light
          case medium
          case heavy
          @available(iOS 13.0, *)
          case soft
          @available(iOS 13.0, *)
          case rigid
          case selection
          case oldSchool

          public func vibrate() {
              switch self {
              case .error:
                  UINotificationFeedbackGenerator().notificationOccurred(.error)
              case .success:
                  UINotificationFeedbackGenerator().notificationOccurred(.success)
              case .warning:
                  UINotificationFeedbackGenerator().notificationOccurred(.warning)
              case .light:
                  UIImpactFeedbackGenerator(style: .light).impactOccurred()
              case .medium:
                  UIImpactFeedbackGenerator(style: .medium).impactOccurred()
              case .heavy:
                  UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
              case .soft:
                  if #available(iOS 13.0, *) {
                      UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                  }
              case .rigid:
                  if #available(iOS 13.0, *) {
                      UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                  }
              case .selection:
                  UISelectionFeedbackGenerator().selectionChanged()
              case .oldSchool:
                  AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
              }
          }
      }
}
