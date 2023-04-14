import UIKit

class IntervalButton: UIButton {

    init(
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor,
        borderColor: UIColor,
        cornerRadius: CGFloat,
        borderWidth: CGFloat
    ){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
