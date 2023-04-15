import UIKit
import Theme

class GraphView: UIView {
    init() {
        super.init(frame: .zero)
        self.skeletonCornerRadius = Theme.skeletonCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
