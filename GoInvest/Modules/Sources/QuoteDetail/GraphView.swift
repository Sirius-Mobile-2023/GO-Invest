import UIKit

class GraphView: UIView {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .green
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
