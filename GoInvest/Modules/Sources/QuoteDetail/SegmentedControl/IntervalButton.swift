import UIKit

class IntervalButton: UIButton {
    
    let borderColor = UIColor.gray
    let cornerRadius: CGFloat = 15.0
    let borderWidth: CGFloat = 1.0
    
    init(titile: String, titleColor: UIColor, backGroundColor: UIColor) {
        super.init(frame: .zero)
        
        self.setTitle(titile, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backGroundColor
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
