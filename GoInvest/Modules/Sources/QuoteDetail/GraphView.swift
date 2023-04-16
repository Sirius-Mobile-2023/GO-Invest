import UIKit
import Theme
import DomainModels

class GraphView: UIView {
    var graphData: QuoteCharts?

    init() {
        super.init(frame: .zero)
        self.skeletonCornerRadius = Theme.skeletonCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
