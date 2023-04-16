import UIKit

public enum Theme {
    // MARK: - Fonts
    public enum Fonts {
        public static let buttonFont = UIFont.systemFont(ofSize: 19, weight: .semibold)
        public static let titleFont = UIFont.systemFont(ofSize: 19, weight: .bold)
        public static let subtitleFont = UIFont.systemFont(ofSize: 17, weight: .light)
    }
    // MARK: - Colors
    public enum Colors {
        public static let background = UIColor(named: "BackgroundColor")
        public static let yellow = UIColor(named: "YellowColor")
        public static let button = UIColor(named: "BlackColor")
        public static let mainText = UIColor(named: "BlackColor")
        public static let buttonText = UIColor(named: "WhiteColor")
    }
    // MARK: - Images
    public enum Images {
        public static let quotesTabBar = UIImage(systemName: "arrow.up.arrow.down")
        public static let profileTabBarUnchecked = UIImage(systemName: "person")
        public static let profileTabBarChecked = UIImage(systemName: "person.fill")
        public static let backNavBar = UIImage(systemName: "chevron.left.circle")
    }
}

public extension Theme {
    // MARK: - Style elements
    static let imageCornerRadius: CGFloat = 20
    static let buttonCornerRadius: CGFloat = 10
    // MARK: - Layout
    static let smallSpacing: CGFloat = 10
    static let bigSpacing: CGFloat = 20
    static let sideOffset: CGFloat = 20
    static let topOffset: CGFloat = 10
    static let buttonHeight: CGFloat = 55
}
